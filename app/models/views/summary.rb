module Views
  class Summary < SimpleDelegator
    # TODO: Use a different way of including helpers
    include ActionView::Helpers::NumberHelper

    delegate :form_name, to: :__getobj__

    def income_validation_fails?
      benefits.eql?(false) && income.nil? && income_text.nil?
    end

    def refund_text
      message = I18n.t("fee_paid_#{refund}", scope: 'summary')
      "#{message}#{payment_date}"
    end

    def savings
      scope = 'questions.savings_and_investment'

      if !online_application.min_threshold_exceeded?
        I18n.t('less', scope: scope)
      elsif online_application.max_threshold_exceeded?
        I18n.t('more', scope: scope)
      elsif online_application.over_66?
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

    def children_age_band
      # puts online_application.children_age_band
      return nil if online_application.children_age_band.blank?

      one = online_application.children_age_band['one'] || 0
      two = online_application.children_age_band['two'] || 0
      return nil if one.zero? && two.zero?

      "#{one} (#{I18n.t('summary.labels.children_age_band_one')}) <br />
       #{two} (#{I18n.t('summary.labels.children_age_band_two')})".html_safe
    end

    def signed_by_representative
      return false unless online_application.applying_on_behalf

      legal_representative?
    end

    def income_period
      return unless online_application.income_period

      I18n.t(online_application.income_period, scope: 'summary.income_period')
    end

    def display_benefits?
      return false if online_application.over_16 == false

      online_application.ho_number.blank?
    end

    def display_ni?
      online_application.over_16 != false
    end

    def display_position?
      legal_representative?
    end

    private

    def legal_representative?
      online_application.legal_representative == 'legal_representative'
    end

    def online_application
      __getobj__
    end

    def payment_date
      ", on #{date_fee_paid.to_fs(:default)}" if refund
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
