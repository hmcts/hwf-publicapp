module Forms
  class IncomeKind < Base
    attribute :applicant, :string_array, default: -> { [] }
    attribute :partner, :string_array, default: -> { [] }
    attribute :children, :integer

    validates_each :applicant do |record, attr, value|
      if value.blank?
        record.errors.add(attr, :blank)
      elsif value.any? { |v| allowed_kinds.exclude?(v.to_sym) }
        record.errors.add(attr, :invalid)
      elsif value.include?('child_benefit') && record.children.to_i.zero?
        record.errors.add(attr, :child_benefit_without_children)
      end
    end

    validates_each :partner do |record, attr, value|
      if value.any? { |v| allowed_kinds.exclude?(v.to_sym) }
        record.errors.add(attr, :invalid)
      end
    end

    validate :none_of_above_selected

    def self.allowed_kinds
      [
        :wage, :net_profit, :child_benefit, :working_credit, :child_credit, :maintenance_payments, :jsa, :esa,
        :universal_credit, :pensions, :rent_from_cohabit, :rent_from_properties, :cash_gifts, :financial_support,
        :loans, :other_income, :none_of_the_above
      ]
    end

    def self.no_income_index
      :none_of_the_above
    end

    def permitted_attributes
      [applicant: [], partner: [], children: []]
    end

    def update_attributes(attributes)
      clear_empty_string(attributes, :applicant)
      clear_empty_string(attributes, :partner)
      super
    end

    private

    def none_of_above_selected
      check_income_and_none_selected(applicant, :applicant)
      check_income_and_none_selected(partner, :partner)
    end

    def check_income_and_none_selected(income_attribute, attribute_name)
      return if income_attribute.count <= 1

      if income_attribute.include?(self.class.no_income_index.to_s)
        errors.add(attribute_name, :none_value_selected)
      end
    end

    def export_params
      export = { income_kind: { applicant:, partner: } }

      export[:income] = 0 if ap_no_income
      export
    end

    def ap_no_income
      (applicant + partner).uniq == [self.class.no_income_index.to_s]
    end

    def clear_empty_string(attributes, attribute)
      attributes[attribute]&.delete_if { |value| value == '' }
    end

    def income_kind_text_values(kinds)
      kinds.map do |kind|
        I18n.t(kind, scope: ['questions.income_kind.kinds'])
      end
    end
  end
end
