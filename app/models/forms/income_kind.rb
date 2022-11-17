module Forms
  class IncomeKind < Base
    attribute :applicant, Array[Integer]
    attribute :partner, Array[Integer]

    validates_each :applicant do |record, attr, value|
      if value.blank?
        record.errors.add(attr, :blank)
      elsif value.any? { |v| allowed_kinds.exclude?(v) }
        record.errors.add(attr, :invalid)
      end
    end

    validates_each :partner do |record, attr, value|
      if value.any? { |v| allowed_kinds.exclude?(v) }
        record.errors.add(attr, :invalid)
      end
    end

    def self.allowed_kinds
      (1..13).to_a
    end

    def self.no_income_index
      13
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

    def export_params
      export = {
        income_kind: {
          applicant: income_kind_text_values(applicant),
          partner: income_kind_text_values(partner)
        }
      }
      export[:income] = 0 if (applicant + partner).uniq == [self.class.no_income_index]
      export
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
