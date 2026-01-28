module Forms
  class IncomeAmount < Base
    attribute :amount, :integer
    attribute :children, :integer
    attribute :married, :boolean
    attribute :min_threshold, :integer
    attribute :max_threshold, :integer

    validates :amount,
              presence: true, numericality: {
                allow_blank: true,
                less_than: 1000000,
                greater_than_or_equal_to: 0
              }

    validate :amount, :income_range

    private

    def export_params
      {}.tap do |export|
        export[:income] = amount if amount
      end
    end

    def income_range
      return unless amount

      if amount < min_threshold || amount > max_threshold
        message = I18n.t('.activemodel.errors.models.forms/income_amount.attributes.amount.not_within_range',
                         min: min_threshold, max: max_threshold)
        errors.add(:amount, message)
      end
    end
  end
end
