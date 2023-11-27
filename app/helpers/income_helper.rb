module IncomeHelper
  def i18n_status_refund_suffix(online_application)
    ''.tap do |suffix|
      suffix << (online_application.married? ? '_married' : '_single')
      suffix << '_refund' if online_application.refund?
    end
  end

  def kinds_alternative_translation(kind)
    return kind if kind != I18n.t('questions.income_kind.kinds.1')

    I18n.t('questions.income_range.wages')
  end
end
