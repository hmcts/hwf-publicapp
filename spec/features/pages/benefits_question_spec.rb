require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "benefit" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:benefit) }

    context 'completing the form correctly' do
      before do
        choose 'benefit_on_benefits_false'
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "dependent" page' do
        expect(page).to have_content 'Do you have any children living with you, or who you support financially?'
      end
    end

    context 'not completing the page correctly' do
      before do
        click_button 'Continue'
      end

      scenario 'I expect to be shown the "benefit" page with error block' do
        expect(page).to have_content 'There is a problem'
      end

      scenario 'I expect the fields to have specific errors' do
        expect(page).to have_xpath('//span[@class="govuk-error-message"]', text: "Select whether you're receiving one of the benefits listed")
      end
    end
  end
end
