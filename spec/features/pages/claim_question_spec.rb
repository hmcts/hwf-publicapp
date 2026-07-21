require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "claim" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:claim) }

    context 'completing the form correctly' do
      before do
        choose :claim_default_number_true
        fill_in :claim_default_identifier, with: 'N1'
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "dob" page' do
        expect(page).to have_text 'What is your date of birth?'
      end
    end

    context 'not completing the page correctly' do
      describe 'leaving all fields empty' do
        before { click_button 'Continue' }

        scenario 'I expect to be shown the "claim" page with error block' do
          expect(page).to have_text 'There is a problem'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Select whether you have a case, claim, appeal or ‘notice to pay’ number')
        end
      end

      context 'selecting yes' do
        before { choose :claim_default_number_true }

        context 'leaving case number field empty' do
          before { click_button 'Continue' }

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Enter a case, claim, appeal or ‘notice to pay’ number')
          end
        end
      end
    end
  end
end
