module Forms
  class SavingsAndInvestmentExtra < Base
    attribute :over_61, Boolean
    attribute :over_16, Boolean
    attribute :amount, Integer

    validates :over_61, inclusion: { in: [true, false] }
    validates :amount,
              presence: true,
              numericality: { allow_blank: true, less_than: 16000 },
              if: proc { |c| c.over_61 == false }

    validate :amount_greater_than_or_equal, if: proc { |c| c.over_61 == false }
    validate :age_against_over_16, if: proc { |c| c.over_61 == true }
    private

    def age_against_over_16
      return if over_16 == true || over_16.nil?

      errors.add(:over_61, :not_over_16)
    end

    def amount_greater_than_or_equal
      return if over_61 == true || amount.nil?

      errors.add(:amount, :greater_than_or_equal_to_ucd) if amount < 4250 && ucd_changes_apply?
      errors.add(:amount, :greater_than_or_equal_to) if amount < 3000 && !ucd_changes_apply?
    end

    def export_params
      { over_61: over_61 }.merge(amount_param)
    end

    def amount_param
      !over_61? && amount.present? ? { amount: amount } : {}
    end
  end
end
