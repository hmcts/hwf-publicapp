require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "dob" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:dob) }

    context 'completing the form correctly' do
      before do
        fill_in :dob_day, with: '01'
        fill_in :dob_month, with: '01'
        fill_in :dob_year, with: '1990'
        fill_in :dob_partner_day, with: '01'
        fill_in :dob_partner_month, with: '01'
        fill_in :dob_partner_year, with: '1990'
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "personal-detail" page' do
        expect(page).to have_content 'What are the full names of both you and your partner?'
      end
    end

    context 'not completing the page correctly' do
      describe 'leaving all fields empty' do
        before { click_button 'Continue' }

        scenario 'I expect to be shown the "dob" page with error block' do
          expect(page).to have_content 'There is a problem'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Enter the date in this format DD/MM/YYYY')
        end
      end

      describe 'by entering a date of birth that is too young' do
        let(:too_young) { Time.zone.yesterday }

        before do
          fill_in :dob_day, with: too_young.day
          fill_in :dob_month, with: too_young.month
          fill_in :dob_year, with: too_young.year
          click_button 'Continue'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'You must be over 15 to use this service')
        end
      end

      describe 'by entering a date of birth that is too old' do
        let(:too_old) { Time.zone.today - 125.years }

        before do
          fill_in :dob_day, with: too_old.day
          fill_in :dob_month, with: too_old.month
          fill_in :dob_year, with: too_old.year
          click_button 'Continue'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Check this date of birth is correct')
        end
      end

      describe 'by entering data that is not a date' do
        before do
          fill_in :dob_day, with: 'foo'
          fill_in :dob_month, with: 'foo'
          fill_in :dob_year, with: 'foo'
          click_button 'Continue'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Enter the date in this format DD/MM/YYYY')
        end
      end
    end
  end
end
