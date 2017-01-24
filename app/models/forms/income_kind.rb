module Forms
  class IncomeKind < Base
    attribute :applicant, Array[Integer]
    attribute :partner, Array[Integer]

    validates_each :applicant do |record, attr, value|
      if value.blank?
        record.errors.add(attr, :blank)
      elsif value.any? { |v| !allowed_kinds.include?(v) }
        record.errors.add(attr, :invalid)
      end
    end

    validates_each :partner do |record, attr, value|
      if value.any? { |v| !allowed_kinds.include?(v) }
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
      {}.tap do |export|
        export[:income] = 0 if (applicant + partner).uniq == [self.class.no_income_index]
      end
    end

    def clear_empty_string(attributes, attribute)
      attributes[attribute]&.delete_if { |value| value == '' }
    end
  end
end
