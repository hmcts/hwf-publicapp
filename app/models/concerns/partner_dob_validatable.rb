module PartnerDobValidatable
  extend ActiveSupport::Concern

  def reset_partner_dob
    @partner_date_of_birth = {}
  end

  def partner_dob_dates
    concat_partner_dob_dates
    @partner_date_of_birth = concat_partner_dob_dates.to_date
  rescue ArgumentError
    @partner_date_of_birth = nil
  end

  def concat_partner_dob_dates
    "#{partner_day}/#{partner_month}/#{partner_year}"
  end

  def partner_dob_age_valid?
    return errors.add(:partner_date_of_birth, :not_a_date) if invalid_partner_date?

    errors.add(:partner_date_of_birth, :too_young, minimum_age: Forms::Dob::MINIMUM_AGE) if partner_too_young?
    errors.add(:partner_date_of_birth, :too_old) if partner_too_old?
  end

  def invalid_partner_date?
    errors.messages.key?(:partner_date_of_birth) ||
      blank_partner_dates? ||
      partner_dates_zeros? ||
      !partner_date_of_birth.is_a?(Date)
  end

  def partner_dates_zeros?
    partner_day.zero? || partner_month.zero? || partner_year.zero?
  end

  def blank_partner_dates?
    partner_day.blank? || partner_month.blank? || partner_year.blank?
  end

  def partner_too_young?
    partner_date_of_birth > minimum_date_of_birth
  end

  def partner_too_old?
    partner_date_of_birth < maximum_date_of_birth
  end

end
