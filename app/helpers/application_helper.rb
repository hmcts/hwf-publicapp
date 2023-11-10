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

    case scope
    when 'questions.dob'
      dob_postfix(online_application)
    when 'questions.personal_detail'
      personal_detail_postfix(online_application)
    when 'questions.savings_and_investment'
      savings_postfix(online_application)
    else
      scope
    end
  end

  def date_formatter(date_value)
    return if date_value.blank?

    date_value.to_fs(:default)
  end

  def ucd_changes_apply?(calculation_scheme)
    FeatureSwitch::CALCULATION_SCHEMAS[1].to_s == calculation_scheme
  end

  def savings_postfix(online_application)
    scope_postfix = []
    scope_postfix << (online_application.married? ? 'married' : 'single')
    scope_postfix << (online_application.refund? ? 'refund' : nil)
    "questions.savings_and_investment_#{scope_postfix.compact.join('_')}"
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
end
