require 'rails_helper'

RSpec.feature 'Changing answers from the summary page' do
  before { disable_postcode_lookup }

  def fill_single_applicant_with_ho_number
    visit '/'
    click_link_or_button 'Start now'
    click_link_or_button 'Continue'
    fill_fee
    fill_form_name
    fill_applying_on_behalf
    choose 'national_insurance_ni_number_present_false'
    click_button 'Continue'
    fill_home_office
    choose 'marital_status_married_false'
    click_button 'Continue'
    fill_savings_and_investment
    fill_savings_and_investment_extra
    fill_dependent
    fill_income_kind
    fill_income_period
    fill_probate
    fill_claim
    fill_in 'dob_day', with: '01'
    fill_in 'dob_month', with: '01'
    fill_in 'dob_year', with: '1980'
    click_button 'Continue'
    fill_in 'personal_detail_first_name', with: 'Bob'
    fill_in 'personal_detail_last_name', with: 'Oliver'
    click_button 'Continue'
    fill_applicant_address
    fill_contact
    fill_apply_type
  end

  def change_ni_number_and_marry_then_return_to_summary
    find("a[href*='/questions/national_insurance']").click
    fill_national_insurance
    choose 'marital_status_married_true'
    click_button 'Continue'
    expect(page).to have_current_path(%r{/questions/partner_national_insurance})
    visit_summary_page
  end

  scenario 'the HO number is gone once an NI number is given' do
    fill_single_applicant_with_ho_number
    expect(page).to have_text 'L1234567'

    change_ni_number_and_marry_then_return_to_summary

    expect(page).to have_no_text 'L1234567'
    expect(page).to have_text 'AB123456A'
  end

  scenario 'the unanswered partner questions are flagged on the summary' do
    fill_single_applicant_with_ho_number
    change_ni_number_and_marry_then_return_to_summary

    expect(page).to have_text 'Please answer the question about your partner’s National Insurance number'
    expect(page).to have_text 'Please give your partner’s date of birth'
    expect(page).to have_text 'Please give your partner’s full name'
    expect(page).to have_text 'Please answer the question about benefits'
  end

  scenario 'the application can be submitted once the flagged questions are answered' do
    fill_single_applicant_with_ho_number
    change_ni_number_and_marry_then_return_to_summary

    find("a[href*='/questions/partner_national_insurance']").click
    fill_partner_national_insurance
    visit_summary_page
    find("a[href*='/questions/benefit']").click
    fill_benefit
    visit_summary_page
    find("a[href*='/questions/dob']", match: :first).click
    fill_dob
    visit_summary_page
    find("a[href*='/questions/personal_detail']", match: :first).click
    fill_personal_detail
    visit_summary_page

    expect(page).to have_no_text 'Please answer the highlighted questions'
    expect(page).to have_text 'Sally Test'

    service = instance_double(SubmitApplication, post: { result: true, message: 'HWF-ABC-123' })
    allow(SubmitApplication).to receive(:new).and_return(service)
    check 'statement_signed_by'
    click_button 'Get a reference number and continue'

    expect(service).to have_received(:post)
  end

  scenario 'the application cannot be submitted with missing partner answers' do
    fill_single_applicant_with_ho_number
    change_ni_number_and_marry_then_return_to_summary
    allow(SubmitApplication).to receive(:new)

    check 'statement_signed_by'
    click_button 'Get a reference number and continue'

    expect(SubmitApplication).not_to have_received(:new)
    expect(page).to have_current_path(%r{/summary})
    expect(page).to have_text 'Please answer the highlighted questions'
  end
end
