module ApplicationHelper
  def ni_number_value(summary)
    summary.ni_number.presence || t('ni_number_no', scope: 'summary.labels')
  end

  def cookies_accepted?
    Forms::Cookie::SettingForm.new(request: request).accepted?
  end

  def show_cookie_banner?
    !Forms::Cookie::SettingForm.new(request: request).preference_set?
  end

  def address_lookup_access_token
    Rails.cache.read('address_lookup')
  end

  def address_lookup_url
    [Rails.configuration.x.address_lookup.endpoint, "/search/places/v1/postcode"].join
  end

  def address_lookup_details_filled?(record)
    record.send(:street).present?
  end

  def title_scope(scope, online_application)
    return scope if online_application.blank?

    scope_postfix = []
    case scope
    when 'questions.savings_and_investment'
      scope_postfix << (online_application.married? ? 'married' : 'single')
      scope_postfix << (online_application.refund? ? 'refund' : nil)
      scope_postfix << (ucd_changes_apply?(@online_application.calculation_scheme) ? 'ucd' : nil)
      "questions.savings_and_investment_#{scope_postfix.compact.join('_')}"
    when 'questions.savings_and_investment_extra'
      scope_postfix << (ucd_changes_apply?(@online_application.calculation_scheme) ? '_ucd' : nil)
      "questions.savings_and_investment_extra#{scope_postfix.compact.join('_')}"
    when 'questions.marital_status'
      scope_postfix << (ucd_changes_apply?(@online_application.calculation_scheme) ? '_ucd' : nil)
      "questions.marital_status#{scope_postfix.compact.join('_')}"
      # statement_signed_by
    else
      scope
    end
  end

  def ucd_changes_apply?(calculation_scheme)
    return FeatureSwitch.active?(:band_calculation) if calculation_scheme.blank?
    calculation_scheme == FeatureSwitch::CALCULATION_SCHEMAS[1].to_s
    false
  end

  def date_formatter(date_value)
    return if date_value.blank?

    date_value.to_fs(:default)
  end
end
