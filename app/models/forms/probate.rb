module Forms
  class Probate < Base
    include ActiveModel::Validations::Callbacks

    attribute :kase, Boolean
    attribute :deceased_name, String
    attr_reader :date_of_death

    attribute :day_date_of_death, Integer
    attribute :month_date_of_death, Integer
    attribute :year_date_of_death, Integer

    before_validation :date_of_death_dates

    validates :kase, inclusion: { in: [true, false] }
    validates :deceased_name, presence: true, length: { maximum: 99 }, if: :kase?

    with_options if: :validate_probate_date_of_death? do
      validates :date_of_death, date: {
        before: :tomorrow,
        allow_blank: false
      }
    end

    private

    def validate_probate_date_of_death?
      validate_date? 'date_of_death' if kase?
    end

    def export_params
      {
        probate: kase,
        deceased_name: kase ? deceased_name : nil,
        date_of_death: kase ? date_of_death_dates : nil
      }
    end

    def tomorrow
      Time.zone.tomorrow
    end

    def date_of_death_dates
      return if date_not_recognized? || blank_dates?

      @date_of_death ||= concat_date_of_death_dates.to_date
    rescue ArgumentError
      errors.add(:date_of_death, :not_a_date)
      @date_of_death = concat_date_of_death_dates
    end

    def concat_date_of_death_dates
      "#{day_date_of_death}/#{month_date_of_death}/#{year_date_of_death}"
    end

    def date_not_recognized?
      errors.messages.key?(:date_of_death)
    end

    def blank_dates?
      day_date_of_death.blank? || month_date_of_death.blank? || year_date_of_death.blank?
    end

  end
end
