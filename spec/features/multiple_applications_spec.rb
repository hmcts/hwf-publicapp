require 'rails_helper'

RSpec.feature 'Multiple applications in one browser' do
  scenario 'applications started in separate tabs keep their answers apart' do
    given_user_answers_questions_up_to(:form_name)
    first_app_id = current_app_id
    fill_form_name

    # A second tab starting a fresh application must not wipe the first one
    given_user_answers_questions_up_to(:form_name)
    second_app_id = current_app_id
    expect(second_app_id).not_to eq(first_app_id)
    fill_et_form_name

    visit question_path(:form_name, app_id: first_app_id)
    expect(page).to have_field('form_name_identifier', with: 'N1')

    visit question_path(:form_name, app_id: second_app_id)
    expect(page).to have_field('form_name_identifier', with: 'ET')
  end

  scenario 'an application url pasted into a different browser session is rejected' do
    given_user_answers_questions_up_to(:form_name)
    stolen_app_id = current_app_id

    Capybara.reset_sessions!
    visit question_path(:form_name, app_id: stolen_app_id)

    expect(page).to have_current_path(root_path, ignore_query: true)
  end

  scenario 'a well-formed application id that was never started is rejected' do
    visit question_path(:form_name, app_id: SecureRandom.uuid)

    expect(page).to have_current_path(root_path, ignore_query: true)
  end

  scenario 'a malformed application id is rejected' do
    visit "/applications/not-a-real-id/questions/form_name"

    expect(page).to have_current_path(root_path, ignore_query: true)
  end
end
