module Calculator
  module CalculatorHelper
    # Provides the feedback text for a given calculation.
    # At present, this does use I18n to generate the text, using approximately 10 different keys to form the
    # complete feedback message.
    # It is currently unknown if this will be suitable for different languages (i.e. welsh)
    # @TODO Review the above comment
    # @param [Calculator::Calculation] calculation The calculation to display feedback for
    # @return [String] The feedback text
    def calculator_feedback_for(calculation)
      if calculation.should_not_get_help

      elsif calculation.should_get_help
        txt = [
            I18n.t('calculator.calculation.feedback.should_get_help'),
            I18n.t('calculator.calculation.feedback.explanation_prefix', fee: number_to_currency(calculation.inputs['fee'], precision: 0, unit: '£'),
                   total_savings: number_to_currency(calculation.inputs['total_savings'], precision: 0, unit: '£')),
            I18n.t("calculator.calculation.feedback.subject.#{calculation.inputs['marital_status']}"),
            I18n.t('calculator.calculation.feedback.explanation')
        ] + calculator_feedback_explanation(calculation)
        txt.join(' ')
      end
    end

    # Formats a calculator value.
    #
    # @TODO Decide if this stays as a type detection based method or has a type lookup from somewhere
    # @TODO Decide if the code that needs this really needs a presenter
    # @param [Object] value The value to be formatted
    # @param [String] field The field that this value is from
    def calculator_auto_format_for(value, field:)
      case value
        when Float then number_to_currency(value, precision: 0, unit: '£')
        when Date then value.strftime('%d/%m/%Y')
        else value
      end
    end

    private

    def calculator_feedback_explanation(calculation)
      remaining_fields = calculation.required_fields_affecting_likelyhood
      return [] if remaining_fields.empty?
      a = [ I18n.t('calculator.calculation.feedback.explanation_suffix') ]
      remaining = remaining_fields.map do |field|
        I18n.t("calculator.calculation.feedback.explanation_suffix_fields.#{field}")
      end
      if remaining.length == 1
        a << remaining.first
      else
        a << remaining[0..-2].join(', ')
        a << I18n.t('calculator.calculation.feedback.explanation_suffix_joining_word')
        a << remaining.last
      end
      a
    end
  end
end