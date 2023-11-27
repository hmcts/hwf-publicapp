module Forms
  class Fee < Base
    include ActiveModel::Validations::Callbacks

    attribute :paid, Boolean
    attribute :date_paid, Date
    attribute :day_date_paid, Integer
    attribute :month_date_paid, Integer
    attribute :year_date_paid, Integer

    before_validation :fee_dates_paid

    validates :paid, inclusion: { in: [true, false] }

    with_options if: :validate_fee_date_paid? do
      validates :date_paid, date: {
        after_or_equal_to: :min_date,
        before_or_equal_to: :max_date,
        allow_blank: false
      }
    end

    private

    def min_date
      Time.zone.today - 3.months
    end

    def max_date
      Time.zone.today
    end

    def validate_fee_date_paid?
      validate_date? 'date_paid' if paid? || date_not_recognized?
    end

    def export_params
      {
        refund: paid,
        date_fee_paid: paid ? fee_dates_paid : nil
      }
    end

    def fee_dates_paid
      return if date_not_recognized? || blank_dates?

      @date_paid ||= concat_dates_paid.to_date
    rescue ArgumentError
      errors.add(:date_paid, :not_a_date)
      @date_paid = concat_dates_paid
    end

    def concat_dates_paid
      "#{day_date_paid}/#{month_date_paid}/#{year_date_paid}"
    end

    def date_not_recognized?
      errors.messages.key?(:date_paid)
    end

    def blank_dates?
      day_date_paid.blank? || month_date_paid.blank? || year_date_paid.blank?
    end
  end
end
