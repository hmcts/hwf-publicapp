module AppTest
  module En
    module Calculator
      class CourtFeePage < ::AppTest::En::Calculator::BasePage
        section :fee, ::AppTest::Calculator::QuestionNumeric, :calculator_question, 'How much is the court or tribunal fee you have to pay (or have paid within the last 3 months)?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
      end
    end
  end
end
