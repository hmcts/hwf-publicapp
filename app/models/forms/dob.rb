module Forms
  class Dob < Base
    include ActiveModel::Validations::Callbacks
    include PartnerDobValidatable

    attr_reader :date_of_birth, :partner_date_of_birth

    attribute :over_61, Boolean
    attribute :is_married, Boolean
    attribute :day, Integer
    attribute :month, Integer
    attribute :year, Integer
    attribute :partner_day, Integer
    attribute :partner_month, Integer
    attribute :partner_year, Integer
    attribute :over_16, Integer

    MINIMUM_AGE = 15
    MAXIMUM_AGE = 120

    before_validation :dob_dates
    before_validation :partner_dob_dates, if: :partner?
    before_validation :reset_partner_dob, unless: :partner?

    validate :dob_age_valid?
    validate :partner_dob_age_valid?, if: :partner?

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
      unless date_of_birth.is_a?(Date)
        errors.add(:date_of_birth, :not_a_date)
      end
    end

    def validate_dob_ranges
      too_young_error if too_young?
      too_old_error if too_old?
      not_over_61_error if not_over_61?
    end

    def too_young?
      return false if over_16 == 'false'

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

    def not_over_61?
      return false if is_married == true
      return false unless over_61 == true

      date_of_birth > (Time.zone.today - 61.years)
    end

    def not_over_61_error
      errors.add(:date_of_birth, :not_over_61)
    end

    def export_params
      dobs = { date_of_birth: dob_dates }
      dobs[:partner_date_of_birth] = partner? ? partner_dob_dates : {}
      dobs
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
