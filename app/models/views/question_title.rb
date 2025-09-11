# frozen_string_literal: false
module Views
  class QuestionTitle
    def initialize(form, online_application)
      @form = form
      @online_application = online_application
    end

    def i18n_title
      'text'.tap do |i18n|
        if (%w[savings_and_investment_extra] + income_questions).include?(@form.id)
          i18n << (@online_application.married? ? '_married' : '_single')
        end
        if (%w[benefit] + income_questions).include?(@form.id) && @online_application.refund?
          i18n << '_refund'
        end
      end
    end

    private

    def income_questions
      %w[income_kind income_range income_amount]
    end
  end
end
