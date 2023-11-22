module TitleHelper

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
    when 'questions.legal_representative_detail'
      legal_representative_detail_postfix(online_application)
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

  def income_kind_postfix(online_application)
    scope_postfix = []
    scope_postfix << (ucd_changes_apply?(online_application.calculation_scheme) ? '_ucd' : nil)
    "questions.income_kind#{scope_postfix.compact.join('_')}"
  end
  
  def legal_representative_detail_postfix(online_application)
    if online_application.legal_representative == 'litigation_friend'
      'questions.legal_representative_detail_friend'
    else
      'questions.legal_representative_detail'
    end
  end
end
