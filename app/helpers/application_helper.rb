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

  # rubocop:disable Metrics/MethodLength
  def title_scope(scope, online_application)
    return scope if online_application.blank?

    case scope
    when 'questions.savings_and_investment'
      savings_postfix(online_application)
    when 'questions.savings_and_investment_extra'
      savings_extra_postfix(online_application)
    when 'questions.marital_status'
      marital_status_postfix(online_application)
    else
      scope
    end
  end
  # rubocop:enable Metrics/MethodLength

  def ucd_changes_apply?(calculation_scheme)
    return FeatureSwitch.active?(:band_calculation) if calculation_scheme.blank?

    calculation_scheme == FeatureSwitch::CALCULATION_SCHEMAS[1].to_s
  end

  def savings_postfix(online_application)
    scope_postfix = []
    scope_postfix << (online_application.married? ? '_married' : '_single')
    scope_postfix << (online_application.refund? ? 'refund' : nil)
    scope_postfix << (ucd_changes_apply?(online_application.calculation_scheme) ? 'ucd' : nil)
    "questions.savings_and_investment#{scope_postfix.compact.join('_')}"
  end

  def savings_extra_postfix(online_application)
    scope_postfix = []
    scope_postfix << (ucd_changes_apply?(online_application.calculation_scheme) ? '_ucd' : nil)
    "questions.savings_and_investment_extra#{scope_postfix.compact.join('_')}"
  end

  def marital_status_postfix(online_application)
    scope_postfix = []
    scope_postfix << (ucd_changes_apply?(online_application.calculation_scheme) ? '_ucd' : nil)
    "questions.marital_status#{scope_postfix.compact.join('_')}"
  end

  def date_formatter(date_value)
    return if date_value.blank?

    date_value.to_fs(:default)
  end
end
