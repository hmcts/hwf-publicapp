require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "national-insurance" page for "Help with fees"' do
    before do
      given_user_answers_questions_up_to(:national_insurance)
    end

    context 'completing the form correctly' do
      describe 'recording a valid NI number' do
        before do
          fill_national_insurance
        end

        scenario 'I expect to be routed to the "marital-status" page' do
          expect(page).to have_content 'Relationship status'
        end
      end
    end

    context 'not completing the page correctly' do
      describe 'not selecting radio button' do
        before do
          click_button 'Continue'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//a[@class="error-link"]', text: 'Select yes if you have National Insurance number')
        end
      end

      describe 'clicking yes and leaving the ni field empty' do
        before do
          choose 'national_insurance_ni_number_present'
          click_button 'Continue'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//a[@class="error-link"]', text: 'Enter your National Insurance number')
        end
      end

      describe 'providing an incorrect value' do
        before do
          choose 'national_insurance_ni_number_present'
          fill_in 'national_insurance_number', with: 'AB123'
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
