module Views
  class Summary < SimpleDelegator
    # TODO: Use a different way of including helpers
    include ActionView::Helpers::NumberHelper

    def income_validation_fails?
      benefits.eql?(false) && income.nil? && income_text.nil?
    end

    def refund_text
      message = I18n.t("fee_paid_#{refund}", scope: 'summary')
      "#{message}#{payment_date}"
    end

    def form_name
      __getobj__.form_name || '—'
    end

    def savings
      scope = 'questions.savings_and_investment'

      if !online_application.min_threshold_exceeded?
        I18n.t('less', scope: scope)
      elsif online_application.max_threshold_exceeded?
        I18n.t('more', scope: scope)
      elsif online_application.over_61?
        I18n.t('between', scope: scope)
      else
        format_currency(online_application.amount)
      end
    end

    def income_text
      if online_application.income_min_threshold_exceeded? == false
        format_below_threshold
      elsif online_application.income_max_threshold_exceeded?
        format_above_threshold
      elsif online_application.income
        format_currency(online_application.income)
      end
    end

    def children_text
      unless children.nil?
        children.positive? ? children.to_s : I18n.t('summary.children_false')
      end
    end

    def case_number?
      case_number.present?
    end

    def full_address
      [street, town, postcode].join(' ')
    end

    private

    def online_application
      __getobj__
    end

    def payment_date
      ", on #{date_fee_paid}" if refund
    end

    def format_currency(amount)
      number_to_currency(amount, precision: 0, unit: '£')
    end

    def income_thresholds
      Views::IncomeThresholds.new(online_application)
    end

    def format_above_threshold
      scope = 'questions.income_range.range'
      I18n.t('more', scope: scope, max_threshold: format_currency(income_thresholds.max_threshold))
    end

    def format_below_threshold
      scope = 'questions.income_range.range'
      I18n.t('less', scope: scope, min_threshold: format_currency(income_thresholds.min_threshold))
    end
  end
end
