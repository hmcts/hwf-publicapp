require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "income_kind" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:income_kind) }

    context 'not completing the page correctly' do
      before do
        click_button 'Continue'
      end

      scenario 'I expect to be shown the "income_kind" page with error block' do
        expect(page).to have_content 'What kind of income do you receive?'
        expect(page).to have_content 'There is a problem'
        expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Select your kinds of income')
      end
    end
  end

  context 'when accessing the "income_range" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:income_range) }

    context 'completing the form correctly' do
      before do
        choose :income_range_choice_between
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "income_amount" page' do
        expect(page).to have_content 'What’s your total monthly income?'
        expect(page).to have_content 'Enter the total monthly amount you receive in income.'
      end
    end

    context 'not completing the page correctly' do
      before do
        click_button 'Continue'
      end

      scenario 'I expect to be shown the "income_range" page with error block' do
        expect(page).to have_content 'How much income do you receive each month?'
        expect(page).to have_content 'There is a problem'
        expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Select your monthly income')
      end
    end
  end

  context 'when accessing the "income_amount" page for "Help with fees"' do
    before do
      travel_to a_day_before_disable_probate_fees
      given_user_answers_questions_up_to(:income_amount)
    end

    after { travel_back }

    context 'completing the form correctly' do
      before do
        fill_in :income_amount_amount, with: '750'
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "probate" page' do
        expect(page).to have_content 'Are you paying a fee for a probate case?'
      end
    end

    context 'not completing the page correctly' do
      before do
        click_button 'Continue'
      end

      scenario 'I expect to be shown the "income_amount" page with error block' do
        expect(page).to have_content 'What’s your total monthly income?'
        expect(page).to have_content 'There is a problem'
        expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: 'Enter how much income do you receive')
      end
    end
  end

  context 'when accessing the "income_kind" before probate is disabled' do
    context 'completing the form correctly' do
      context 'when "no income" selected' do
        before do
          travel_to a_day_before_disable_probate_fees
          given_user_answers_questions_up_to(:income_kind)
          check :income_kind_applicant_13
          click_button 'Continue'
        end

        after { travel_back }

        scenario 'I expect to be routed to the "probate" page' do
          expect(page).to have_content 'Are you paying a fee for a probate case?'
        end
      end

      context 'when some income sources selected' do
        before do
          given_user_answers_questions_up_to(:income_kind)
          check :income_kind_applicant_2
          check :income_kind_applicant_8
          click_button 'Continue'
        end

        scenario 'I expect to be routed to the "income_range" page' do
          expect(page).to have_content 'How much income do you receive each month?'
        end
      end
    end
  end
end
