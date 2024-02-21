module Forms
  class IncomeKind < Base
    attribute :applicant, [Integer]
    attribute :partner, [Integer]

    validates_each :applicant do |record, attr, value|
      if value.blank?
        record.errors.add(attr, :blank)
      elsif value.any? { |v| allowed_kinds_ucd.exclude?(v) }
        record.errors.add(attr, :invalid)
      end
    end

    validates_each :partner do |record, attr, value|
      if value.any? { |v| allowed_kinds_ucd.exclude?(v) }
        record.errors.add(attr, :invalid)
      end
    end

    validate :none_of_above_selected

    def self.allowed_kinds
      (1..13).to_a
    end

    def self.allowed_kinds_ucd
      (1..17).to_a
    end

    def self.no_income_index
      13
    end

    def self.no_income_index_ucd
      17
    end

    def permitted_attributes
      [applicant: [], partner: []]
    end

    def update_attributes(attributes)
      clear_empty_string(attributes, :applicant)
      clear_empty_string(attributes, :partner)
      super(attributes)
    end

    private

    def none_of_above_selected
      check_income_and_none_selected(applicant, :applicant)
      check_income_and_none_selected(partner, :partner)
    end

    def check_income_and_none_selected(attr, attribute_name)
      return if attr.count <= 1

      if ucd_changes_apply? == false && attr.include?(self.class.no_income_index)
        errors.add(attribute_name, :none_value_selected)
      elsif ucd_changes_apply? && attr.include?(self.class.no_income_index_ucd)
        errors.add(attribute_name, :none_value_selected)
      end
    end

    # rubocop:disable Metrics/MethodLength
    def export_params
      export = if ucd_changes_apply? == false
                 {
                   income_kind: {
                     applicant: income_kind_text_values(applicant),
                     partner: income_kind_text_values(partner)
                   }
                 }
               else
                 {
                   income_kind: {
                     applicant: income_kind_text_values_ucd(applicant),
                     partner: income_kind_text_values_ucd(partner)
                   }
                 }
               end

      export[:income] = 0 if ap_no_income_ucd
      export[:income] = 0 if ap_no_income
      export
    end
    # rubocop:enable Metrics/MethodLength

    def ap_no_income_ucd
      (applicant + partner).uniq == [self.class.no_income_index_ucd] && ucd_changes_apply?
    end

    def ap_no_income
      (applicant + partner).uniq == [self.class.no_income_index] && ucd_changes_apply? == false
    end

    def clear_empty_string(attributes, attribute)
      attributes[attribute]&.delete_if { |value| value == '' }
    end

    def income_kind_text_values(kinds)
      kinds.map do |kind|
        I18n.t(kind, scope: ['questions.income_kind.kinds'])
      end
    end

    def income_kind_text_values_ucd(kinds)
      kinds.map do |kind|
        I18n.t(kind, scope: ['questions.income_kind_ucd.kinds'])
      end
    end
  end
end
