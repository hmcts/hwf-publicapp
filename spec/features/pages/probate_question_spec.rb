require 'rails_helper'

RSpec.feature 'As a user' do
  before { travel_to a_day_before_disable_probate_fees }

  context 'when accessing the "probate" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:probate) }

    context 'completing the form correctly' do
      before do
        choose 'probate_kase_true'
        fill_in :probate_deceased_name, with: 'foo'
        fill_in :probate_day_date_of_death, with: Time.zone.yesterday.day
        fill_in :probate_month_date_of_death, with: Time.zone.yesterday.month
        fill_in :probate_year_date_of_death, with: Time.zone.yesterday.year
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "claim" page' do
        expect(page).to have_content 'Do you have a case, claim, appeal or ‘notice to pay’ number?'
      end
    end

    context 'not completing the page correctly' do
      describe 'leaving all fields empty' do
        before do
          click_button 'Continue'
        end

        scenario 'I expect to be shown the "probate" page with error block' do
          expect(page).to have_content 'There is a problem'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: "Select whether you're paying a fee for a probate case")
        end
      end

      context 'selecting yes to probate case' do
        before { choose :probate_kase_true }

        context 'leaving deceased_name blank' do
          before { click_button 'Continue' }

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: "Please enter the deceased's name")
          end
        end

        context 'leaving date_of_death empty' do
          before { click_button 'Continue' }

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Enter the date')
          end
        end

        context 'entering date_of_death that is not a date' do
          before do
            fill_in :probate_day_date_of_death, with: 'foo'
            fill_in :probate_month_date_of_death, with: 'foo'
            fill_in :probate_year_date_of_death, with: 'foo'
            click_button 'Continue'
          end

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Enter the date in this format DD/MM/YYYY')
          end
        end

        context 'entering date_of_death that is too old' do
          let(:long_ago) { Time.zone.today - 21.years }

          before do
            fill_in :probate_day_date_of_death, with: long_ago.day
            fill_in :probate_month_date_of_death, with: long_ago.month
            fill_in :probate_year_date_of_death, with: long_ago.year
            click_button 'Continue'
          end

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'The date of death must have been in the last 20 years')
          end
        end

        context 'entering date_of_death that is in the future' do
          let(:future_date) { Time.zone.tomorrow }

          before do
            fill_in :probate_day_date_of_death, with: future_date.day
            fill_in :probate_month_date_of_death, with: future_date.month
            fill_in :probate_year_date_of_death, with: future_date.year

            click_button 'Continue'
          end

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: "This date can't be in the future")
          end
        end
      end
    end
  end
end
