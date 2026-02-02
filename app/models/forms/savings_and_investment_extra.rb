module Forms
  class SavingsAndInvestmentExtra < Base
    attribute :over_66, :boolean
    attribute :over_16, :boolean
    attribute :amount, :integer

    validates :over_66, inclusion: { in: [true, false] }
    validates :amount,
              presence: true,
              numericality: { allow_blank: true, less_than: 16000 },
              if: proc { |c| c.over_66 == false }

    validate :amount_greater_than_or_equal, if: proc { |c| c.over_66 == false }
    validate :age_against_over_16, if: proc { |c| c.over_66 == true }
    private

    def age_against_over_16
      return if over_16 == true || over_16.nil?

      errors.add(:over_66, :not_over_16)
    end

    def amount_greater_than_or_equal
      return if over_66 == true || amount.nil?

      errors.add(:amount, :greater_than_or_equal_to) if amount < 4250
    end

    def export_params
      { over_66: over_66 }.merge(amount_param)
    end

    def amount_param
      !over_66? && amount.present? ? { amount: amount } : {}
    end
  end
end
