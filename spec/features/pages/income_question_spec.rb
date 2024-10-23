require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "income_kind" page for "Help with fees"' do
    before do
      given_user_answers_questions_up_to(:income_kind)
    end

    context 'not completing the page correctly' do
      before do
        click_button 'Continue'
      end

      scenario 'I expect to be shown the "income_kind" page with error block' do
        expect(page).to have_content 'Types of income you and your partner have received'
        expect(page).to have_content 'There is a problem'
        expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Select your kinds of income')
      end
    end

    context 'completing the form correctly' do
      before do
        fill_income_kind
      end

      scenario 'I expect to be routed to the "income_period" page' do
        expect(page).to have_content 'How much income did you and your partner receive?'
        expect(page).to have_content 'You need to include income you and your partner received in the last calendar month or provide a three month average from:'
      end
    end
  end

  context 'when accessing the "income_period" page for "Help with fees"' do
    before do
      travel_to a_day_before_disable_probate_fees
      given_user_answers_questions_up_to(:income_kind)
    end

    context 'completing the form correctly' do
      before do
        fill_income_kind
        fill_income_period
      end

      scenario 'I expect to be routed to the "probate" page' do
        expect(page).to have_content 'Are you paying a fee for a probate case?'
      end
    end

    context 'not completing the page correctly' do
      before do
        fill_income_kind
        click_button 'Continue'
      end

      scenario 'I expect to be shown the "income_amount" page with error block' do
        expect(page).to have_content 'How much income did you and your partner receive?'
        expect(page).to have_content 'There is a problem'
        expect(page).to have_xpath('//p[@class="govuk-error-message"]', text: 'Enter how much income do you receive')
      end
    end
  end
end
