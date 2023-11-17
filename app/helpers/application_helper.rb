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
    when 'questions.dob'
      dob_postfix(online_application)
    when 'questions.personal_detail'
      personal_detail_postfix(online_application)
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

  def date_formatter(date_value)
    return if date_value.blank?

    date_value.to_fs(:default)
  end

  def ucd_changes_apply?(calculation_scheme)
    FeatureSwitch::CALCULATION_SCHEMAS[1].to_s == calculation_scheme
  end

  def dob_postfix(online_application)
    if ucd_changes_apply?(online_application.calculation_scheme) && online_application.married?
      "questions.dob_married" if online_application.married?
    else
      'questions.dob'
    end
  end

  def personal_detail_postfix(online_application)
    if ucd_changes_apply?(online_application.calculation_scheme) && online_application.married?
      "questions.personal_detail_married" if online_application.married?
    else
      'questions.personal_detail'
    end
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
end
