module Forms
  class IncomePeriod < Base
    attribute :amount, Integer
    attribute :income_period, String

    validates :amount, presence: true, numericality: {
                allow_blank: true,
                less_than: 1000000,
                greater_than_or_equal_to: 0
              }
    validates :income_period, presence: true
    private

    def export_params
      {
        income: amount,
        income_period: income_period
      }
    end
  end
end
