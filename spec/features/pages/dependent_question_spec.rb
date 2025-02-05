require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "dependent" page for "Help with fees"' do
    before do
      given_user_answers_questions_up_to(:dependent)
    end

    context 'completing the form correctly' do
      before do
        fill_dependent
      end

      scenario 'I expect to be routed to the "income_kind" page' do
        expect(page).to have_content 'Types of income you and your partner have received'
      end
    end
  end
end
