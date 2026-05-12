require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "savings-and-investment" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:savings_and_investment) }

    context 'completing the form correctly' do
      before do
        choose 'savings_and_investment_choice_less'
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "benefits" page' do
        expect(page).to have_text 'Do you receive any of the following benefits?'
      end
    end

    context 'not completing the page correctly' do
      before do
        click_button 'Continue'
      end

      scenario 'I expect to be shown the "savings-and-investment" page with error block' do
        expect(page).to have_text 'There is a problem'
      end

      scenario 'I expect the fields to have specific errors' do
        expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Select how much you have in savings and investments')
      end
    end
  end
end
