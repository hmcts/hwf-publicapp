require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "fee" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:fee) }

    context 'completing a non-refund form correctly' do
      before do
        choose 'fee_paid_false'
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "national-insurance" page' do
        expect(page).to have_content 'Do you have a National Insurance number?'
      end
    end

    context 'not completing the page correctly' do
      describe 'leaving the fields empty' do
        before { click_button 'Continue' }

        scenario 'I expect to be shown the "fee" page with error block' do
          expect(page).to have_content 'There is a problem'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: "Select whether you've already paid the fee")
        end
      end

      describe 'selecting yes to fee paid' do
        before { choose 'fee_paid_true' }

        describe 'leaving date_paid blank' do
          before { click_button 'Continue' }

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="govuk-error-message" and .="Enter the date in this format DD/MM/YYYY"]')
          end
        end

        describe 'providing an invalid date' do
          before do
            fill_in 'fee_day_date_paid', with: '30'
            fill_in 'fee_month_date_paid', with: '2'
            fill_in 'fee_year_date_paid', with: '2016'
            click_button 'Continue'
          end

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'That date is not recognised')
          end

          scenario 'I expect the incorrect data to be shown' do
            expect(page).to have_xpath('//input[@id="fee_day_date_paid" and @value="30"]')
            expect(page).to have_xpath('//input[@id="fee_month_date_paid" and @value="2"]')
            expect(page).to have_xpath('//input[@id="fee_year_date_paid" and @value="2016"]')
          end
        end

        describe 'when the date is too old' do
          let(:old_date) { 4.months.ago }

          before do
            fill_in 'fee_day_date_paid', with: old_date.day
            fill_in 'fee_month_date_paid', with: old_date.month
            fill_in 'fee_year_date_paid', with: old_date.year
            click_button 'Continue'
          end

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'The application must have been made in the last 3 months')
          end

          scenario 'I expect the incorrect data to be shown' do
            expect(page).to have_xpath("//input[@id='fee_day_date_paid' and @value='#{old_date.day}']")
            expect(page).to have_xpath("//input[@id='fee_month_date_paid' and @value='#{old_date.month}']")
            expect(page).to have_xpath("//input[@id='fee_year_date_paid' and @value='#{old_date.year}']")
          end
        end

        describe 'when the date is in the future' do
          let(:future_date) { 4.months.from_now }

          before do
            fill_in 'fee_day_date_paid', with: future_date.day
            fill_in 'fee_month_date_paid', with: future_date.month
            fill_in 'fee_year_date_paid', with: future_date.year
            click_button 'Continue'
          end

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: "This date can't be in the future")
          end

          scenario 'I expect the incorrect data to be shown' do
            expect(page).to have_xpath("//input[@id='fee_day_date_paid' and @value='#{future_date.day}']")
            expect(page).to have_xpath("//input[@id='fee_month_date_paid' and @value='#{future_date.month}']")
            expect(page).to have_xpath("//input[@id='fee_year_date_paid' and @value='#{future_date.year}']")
          end
        end
      end
    end
  end
end
