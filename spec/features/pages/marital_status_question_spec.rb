require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "marital_status" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:marital_status) }

    context 'completing the form correctly' do
      before do
        choose 'marital_status_married_false'
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "savings-and-investment" page' do
        expect(page).to have_text 'How much do you have in savings and investments?'
      end
    end

    context 'not completing the page correctly' do
      before do
        click_button 'Continue'
      end

      scenario 'I expect to be shown the "marital_status" page with error block' do
        expect(page).to have_text 'There is a problem'
      end

      scenario 'I expect the fields to have specific errors' do
        expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: "Select whether you're single, married or living with someone and sharing an income")
      end
    end
  end
end
