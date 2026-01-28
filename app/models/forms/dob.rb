module Forms
  class Dob < Base # rubocop:disable Metrics/ClassLength
    include ActiveModel::Validations::Callbacks
    include PartnerDobValidatable

    attr_reader :date_of_birth, :partner_date_of_birth

    attribute :over_66, :boolean
    attribute :is_married, :boolean
    attribute :ni_number_present, :boolean
    attribute :day, :integer
    attribute :month, :integer
    attribute :year, :integer
    attribute :partner_day, :integer
    attribute :partner_month, :integer
    attribute :partner_year, :integer
    attribute :over_16, :string

    MINIMUM_AGE = 15
    MAXIMUM_AGE = 120

    before_validation :dob_dates
    # rubocop:disable Lint/LiteralAsCondition
    before_validation :partner_dob_dates, if: :is_married? && :ni_number_present?
    before_validation :reset_partner_dob, unless: :is_married? && :ni_number_present?
    # rubocop:enable Lint/LiteralAsCondition

    validate :dob_age_valid?
    validate :partner_dob_age_valid?, if: -> { is_married? && ni_number_present? }

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
      over_16_answer_match_dob?
      too_young_error if too_young? && over_16 != 'true'
      too_old_error if too_old?
      not_over_66_error if not_over_66?
      not_under_66_error if not_under_66?
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

    def not_over_66?
      return false unless over_66 == true

      age_66 = Time.zone.today - 66.years
      if is_married == true
        return false if partner_date_of_birth.blank?

        date_of_birth > age_66 && partner_date_of_birth > age_66
      else
        date_of_birth > age_66
      end
    end

    def not_over_66_error
      errors.add(:date_of_birth, :not_over_66) unless is_married == true
      errors.add(:date_of_birth, :not_over_66_married) if is_married == true
    end

    def not_under_66?
      return false unless over_66 == false

      age_66 = Time.zone.today - 66.years
      if is_married == true
        return false if partner_date_of_birth.blank?

        date_of_birth < age_66 && partner_date_of_birth < age_66
      else
        date_of_birth < age_66
      end
    end

    def not_under_66_error
      errors.add(:date_of_birth, :not_under_66) unless is_married == true
      errors.add(:date_of_birth, :not_under_66_married) if is_married == true
    end

    def over_16_answer_match_dob?
      if over_16 == 'false' && dob_over_16?
        errors.add(:date_of_birth, :not_under_16)
      elsif over_16 == 'true' && !dob_over_16?
        errors.add(:date_of_birth, :not_over_16)
      end
    end

    def dob_over_16?
      (date_of_birth + 16.years) <= Time.zone.today
    end

    def export_params
      {
        date_of_birth: dob_dates,
        partner_date_of_birth: partner_dob_dates
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
end # rubocop:enable Metrics/ClassLength
