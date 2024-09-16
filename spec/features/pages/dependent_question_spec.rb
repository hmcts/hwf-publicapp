require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "dependent" page for "Help with fees"' do
    before do
      given_user_answers_questions_up_to(:dependent)
    end

    context 'completing the form correctly' do
      before do
        fill_dependent(true)
      end

      scenario 'I expect to be routed to the "income_kind" page' do
        expect(page).to have_content 'Types of income you and your partner have received'
      end
    end

    context 'not completing the page correctly' do
      describe 'leaving all fields empty' do
        before do
          click_button 'Continue'
        end

        scenario 'I expect to be shown the "dependent" page with error block' do
          expect(page).to have_content 'There is a problem'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//a[@class="error-link"]', text: 'You need to say whether you have financially dependent children')
        end
      end

      context 'selecting yes to probate case' do
        before { choose :dependent_children_true }

        context 'leaving children_number blank' do
          before { click_button 'Continue' }

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//a[@class="error-link"]', text: 'Enter number of children in this age category')
            expect(page).to have_xpath('//a[@class="error-link"]', text: 'You must enter a number greater than 0')
          end
        end

        context 'entering text as children_number input' do
          before do
            fill_in :dependent_children_age_band_one, with: 'foo'
            click_button 'Continue'
          end

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//a[@class="error-link"]', text: 'You must enter a number greater than 0')
          end
        end
      end
    end
  end
end
