module FeatureSteps
  def given_user_answers_questions_up_to(question)
    visit '/'
    click_link_or_button 'Apply now'

    QuestionFormFactory::IDS.take_while { |id| id != question }.each do |id|
      next if ProbateFeesSwitch.disable_probate_fees? && id == :probate

      send("fill_#{id}")
    end
  end

  def given_user_provides_all_data
    given_user_answers_questions_up_to(:contact)
    fill_contact
  end

  def given_user_provides_all_data_for_refund
    visit '/'
    click_link_or_button 'Apply now'
    fill_form_name
    fill_fee(true)
    fill_marital_status
    fill_savings_and_investment
    fill_savings_and_investment_extra
    fill_benefit
    fill_dependent
    fill_income_kind
    fill_income_range
    fill_income_amount
    fill_probate unless ProbateFeesSwitch.disable_probate_fees?
    fill_claim
    fill_national_insurance
    fill_dob
    fill_personal_detail
    fill_applicant_address
    fill_contact
  end

  def given_user_provides_all_data_for_below_threshold_income
    visit '/'
    click_link_or_button 'Apply now'
    fill_form_name
    fill_fee(true)
    fill_marital_status
    fill_savings_and_investment
    fill_savings_and_investment_extra
    fill_benefit
    fill_dependent
    fill_income_kind
    fill_income_range(below: true)
    fill_probate unless ProbateFeesSwitch.disable_probate_fees?
    fill_claim
    fill_national_insurance
    fill_dob
    fill_personal_detail
    fill_applicant_address
    fill_contact
  end

  def given_user_provides_all_data_for_benefit
    visit '/'
    click_link_or_button 'Apply now'
    fill_form_name
    fill_fee
    fill_marital_status
    fill_savings_and_investment
    fill_savings_and_investment_extra
    fill_benefit(true)
    fill_probate unless ProbateFeesSwitch.disable_probate_fees?
    fill_claim
    fill_national_insurance
    fill_dob
    fill_personal_detail
    fill_applicant_address
    fill_contact
  end

  def given_user_starts_an_application
    given_user_answers_questions_up_to(:savings_and_investment)
  end

  def given_user_fills_in_few_questions
    given_user_answers_questions_up_to(:dependent)
  end

  def given_user_is_reading_the_home_page
    visit '/'
  end

  def when_they_submit_the_application
    click_link_or_button 'Submit application and continue'
  end

  def when_they_start_new_application
    click_link_or_button 'Apply now'
  end

  def when_they_go_back_to_homepage_and_start_again
    visit '/'
    when_they_start_new_application
  end

  def when_they_restart_the_application
    click_link_or_button 'Cancel application'
  end

  def when_they_try_to_proceed_after_long_time
    fill_dependent
  end

  def when_they_apply_for_help_with_et_case
    when_they_go_back_to_homepage_and_start_again
    fill_et_form_name
    fill_fee
    fill_marital_status
    fill_savings_and_investment
    fill_savings_and_investment_extra
    fill_benefit
    fill_dependent
    fill_income_kind
    fill_income_range(true)
    fill_probate
    fill_claim
    fill_national_insurance
    fill_dob
    fill_personal_detail
    fill_applicant_address
    fill_contact
    when_they_submit_the_application
  end

  def when_they_apply_for_help_with_et_case_up_to_step_12
    fill_et_form_name
    fill_fee
    fill_marital_status
    fill_savings_and_investment
    fill_savings_and_investment_extra
    fill_benefit
    fill_dependent
    fill_income_kind
    fill_income_range(true)
    fill_probate
  end

  def when_they_continue_from_step12_up_to_summary
    fill_claim
    fill_national_insurance
    fill_dob
    fill_personal_detail
    fill_applicant_address
    fill_contact
  end

  def then_their_data_is_not_persisted
    visit start_session_path
    form_name = page.find_field('form_name_identifier').text
    expect(form_name).to be_empty
  end
  alias then_their_data_is_deleted then_their_data_is_not_persisted

  def then_they_are_redirected_to_homepage_with_expiry_message
    expect(page).to have_text 'Apply for help with court and tribunal fees'
    expect(page).to have_text "You didn't enter any information for more than 60 minutes so you need to start your application again."
  end

  def then_they_are_on_the_first_question
    expect(page).to have_text 'What number is on your court or tribunal form?'
  end

  def then_they_cannot_procced
    expect(page).to have_content 'Check details'
    expect(page).to have_content 'Not receiving eligible benefits'
    expect(page).to have_content 'IncomePlease answer questions about your income'
    expect(page).to have_content 'You’ve made changes. Please answer the highlighted questions to complete your application.'
  end

  def then_they_can_proceed
    expect(page).to have_content 'Check details'
    expect(page).to have_content 'Not receiving eligible benefits'
    expect(page).to have_content 'IncomeLess than £1,085'
    expect(page).to have_content 'Submit application and continue'
  end

  def fill_contact
    fill_in 'contact_email', with: 'foo@bar.com'
    click_button 'Continue'
  end

  def fill_applicant_address
    fill_in 'applicant_address_address', with: 'Foo Street'
    fill_in 'applicant_address_postcode', with: 'Bar'
    click_button 'Continue'
  end

  def fill_personal_detail
    fill_in 'personal_detail_title', with: 'Sir'
    fill_in 'personal_detail_first_name', with: 'Bob'
    fill_in 'personal_detail_last_name', with: 'Oliver'
    click_button 'Continue'
  end

  def fill_dob
    fill_in 'dob_date_of_birth', with: '01/01/1980'
    click_button 'Continue'
  end

  def fill_national_insurance
    fill_in 'national_insurance_number', with: 'AB123456A'
    click_button 'Continue'
  end

  def fill_form_name
    fill_in 'form_name_identifier', with: 'N1'
    click_button 'Continue'
  end

  def fill_et_form_name
    fill_in 'form_name_identifier', with: 'ET'
    click_button 'Continue'
  end

  def fill_claim
    choose 'claim_default_number_false'
    click_button 'Continue'
  end

  def fill_probate
    choose 'probate_kase_false'
    click_button 'Continue'
  end

  def fill_fee(refund = false)
    if refund
      choose 'fee_paid_true'
      fill_in :fee_date_paid, with: 3.weeks.ago
    else
      choose 'fee_paid_false'
    end

    click_button 'Continue'
  end

  def fill_income_kind
    check 'income_kind_applicant_1'
    click_button 'Continue'
  end

  def fill_income_range(below = false)
    if below
      choose :income_range_choice_less
    else
      choose :income_range_choice_between
    end
    click_button 'Continue'
  end

  def fill_income_amount
    fill_in :amount, with: 100.0
    click_button 'Continue'
  end

  def fill_dependent
    choose 'dependent_children_false'
    click_button 'Continue'
  end

  def fill_benefit(benefit = false)
    choose "benefit_on_benefits_#{benefit}"
    click_button 'Continue'
  end

  def fill_savings_and_investment
    choose 'savings_and_investment_choice_between'
    click_button 'Continue'
  end

  def fill_savings_and_investment_extra
    choose 'savings_and_investment_extra_over_61_false'
    fill_in :savings_and_investment_extra_amount, with: '6300'
    click_button 'Continue'
  end

  def fill_marital_status
    choose 'marital_status_married_false'
    click_button 'Continue'
  end
end

RSpec.configure do |config|
  config.include FeatureSteps, type: :feature
end
