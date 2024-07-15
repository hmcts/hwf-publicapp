require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "savings-and-investment extra" page for "Help with fees"' do
    before do
      given_user_answers_questions_up_to(:savings_and_investment)
      choose 'savings_and_investment_choice_between'
      click_button 'Continue'
    end

    context 'completing the form correctly' do
      before do
        choose 'savings_and_investment_extra_over_66_false'
        fill_in 'savings_and_investment_extra_amount', with: 6000
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "benefits" page' do
        expect(page).to have_content 'Do you receive any of the following benefits?'
      end
    end

    context 'not completing the page correctly' do
      before do
        click_button 'Continue'
      end

      scenario 'I expect to be shown the "savings-and-investment extra" page with error block' do
        expect(page).to have_content 'There is a problem'
      end

      scenario 'I expect the fields to have specific errors' do
        expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Select if you or your partner are over 66')
      end
    end
  end
end
