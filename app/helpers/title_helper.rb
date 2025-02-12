module TitleHelper

  # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
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
      savings_extra_postfix
    when 'questions.marital_status'
      marital_status_postfix
    when 'questions.legal_representative_detail'
      legal_representative_detail_postfix(online_application)
    when 'questions.income_kind'
      income_kind_postfix
    when 'questions.income_period'
      income_period_postfix(online_application)
    else
      scope
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity

  def date_formatter(date_value)
    return if date_value.blank?

    date_value.to_fs(:default)
  end

  def savings_postfix(online_application)
    scope_postfix = []
    scope_postfix << (online_application.married? ? '_married' : '_single')
    scope_postfix << (online_application.refund? ? 'refund' : nil)
    "questions.savings_and_investment#{scope_postfix.compact.join('_')}"
  end

  def dob_postfix(online_application)
    if online_application.married? && online_application.ni_number_present?
      "questions.dob_married" if online_application.married?
    else
      'questions.dob'
    end
  end

  def personal_detail_postfix(online_application)
    if online_application.married? && online_application.ni_number_present?
      "questions.personal_detail_married"
    else
      'questions.personal_detail'
    end
  end

  def income_kind_postfix
    scope_postfix = []
    "questions.income_kind#{scope_postfix.compact.join('_')}"
  end

  def savings_extra_postfix
    scope_postfix = []
    "questions.savings_and_investment_extra#{scope_postfix.compact.join('_')}"
  end

  def marital_status_postfix
    scope_postfix = []
    "questions.marital_status#{scope_postfix.compact.join('_')}"
  end

  def legal_representative_detail_postfix(online_application)
    if online_application.legal_representative == 'litigation_friend'
      'questions.legal_representative_detail_friend'
    else
      'questions.legal_representative_detail'
    end
  end

  def income_period_postfix(online_application)
    scope_postfix = (online_application.married? ? 'married' : 'single')
    "questions.income_period_#{scope_postfix}"
  end
end
