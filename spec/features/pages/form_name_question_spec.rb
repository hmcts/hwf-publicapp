require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "form-name" page for "Help with fees"' do

    context 'completing the form correctly' do
      before do
        given_user_answers_questions_up_to(:form_name)
        fill_in :form_name_identifier, with: 'N1'
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "Apply on behalf of" page' do
        expect(page).to have_content 'Is the application on behalf of someone else?'
      end
    end

    context 'not completing the page correctly' do
      before do
        given_user_answers_questions_up_to(:form_name)
        click_button 'Continue'
      end

      scenario 'I expect the form_name field to have an error' do
        expect(page).to have_content "Enter a valid form number or select 'I don't have a form'"
      end
    end
  end
end
