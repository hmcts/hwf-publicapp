require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "national-insurance" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:national_insurance) }

    context 'completing the form correctly' do
      describe 'recording a valid NI number' do
        before do
          fill_in :number, with: 'AB123456A'
          click_button 'Continue'
        end

        scenario 'I expect to be routed to the "marital-status" page' do
          expect(page).to have_content 'Are you single, married or living with someone and sharing an income?'
        end
      end
    end

    context 'not completing the page correctly' do
      describe 'leaving the field empty' do
        before { click_button 'Continue' }

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Enter your National Insurance number')
        end
      end

      describe 'providing an incorrect value' do
        before do
          fill_in :number, with: 'AB123'
          click_button 'Continue'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Enter a valid National Insurance number')
        end

        scenario 'I expect the incorrect data to be shown' do
          expect(page).to have_xpath('//input[@id="national_insurance_number" and @value="AB123"]')
        end
      end
    end
  end
end
