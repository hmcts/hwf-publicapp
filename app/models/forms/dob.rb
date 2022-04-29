module Forms
  class Dob < Base
    include ActiveModel::Validations::Callbacks

    attr_reader :date_of_birth

    attribute :day, Integer
    attribute :month, Integer
    attribute :year, Integer

    MINIMUM_AGE = 15
    MAXIMUM_AGE = 120

    before_validation :dob_dates

    validate :dob_age_valid?

    private

    def minimum_date_of_birth
      Time.zone.today - MINIMUM_AGE.years
    end

    def maximum_date_of_birth
      Time.zone.today - MAXIMUM_AGE.years
    end

    def dob_age_valid?
      return false if date_not_recognized?

      validate_dob
      validate_dob_ranges unless errors.include?(:date_of_birth)
    end

    def validate_dob
      if !date_of_birth.is_a?(Date)
        errors.add(:date_of_birth, :not_a_date)
      end
    end

    def validate_dob_ranges
      too_young_error if too_young?
      too_old_error if too_old?
    end

    def too_young?
      date_of_birth > minimum_date_of_birth
    end

    def too_young_error
      errors.add(:date_of_birth, :too_young, minimum_age: MINIMUM_AGE)
    end

    def too_old?
      date_of_birth < maximum_date_of_birth
    end

    def too_old_error
      errors.add(:date_of_birth, :too_old)
    end

    def export_params
      {
        date_of_birth: dob_dates
      }
    end

    def dob_dates
      return if date_not_recognized? || blank_dates?

      @date_of_birth ||= concat_dob_dates.to_date
    rescue ArgumentError
      errors.add(:date_of_birth, :not_a_date)
      @date_of_birth = concat_dob_dates
    end

    def concat_dob_dates
      "#{day}/#{month}/#{year}"
    end

    def date_not_recognized?
      errors.messages.key?(:date_of_birth)
    end

    def blank_dates?
      day.blank? || month.blank? || year.blank?
    end

  end
end
