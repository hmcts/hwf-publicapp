class SummaryPage < BasePage
  set_url '/summary'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 24 of 25'
    element :header, 'h1', text: 'Check details'
    element :representative_header, 'h1', text: 'Representative details'
    element :personal_header, 'h1', text: 'Personal details'
    element :application_header, 'h1', text: 'Application details'
    element :check_details_hint, 'p', text: 'Please check your details are correct. If you make changes, you may have to answer new questions and confirm information you’ve already entered.'
    element :probate, '.govuk-summary-list__row', text: 'Probate case No'
    element :declaration_of_truth, 'h2', text: 'Declaration and statement of truth'
    element :declaration_of_truth_checkbox, 'label', text: 'I am the applicant or litigation friend completing this application.'
    sections :summary_row, '.govuk-summary-list__row' do
      element :action, 'a', text: 'Change'
    end
    element :submit_application_button, 'input[value="Get a reference number and continue"]'
    element :error, '.govuk-error-summary__body', text: 'You’ve made changes. Please answer the highlighted questions to complete your application.'
  end

  def home_office_number
    to_fee_page
    fee_page.submit_fee_no
    form_name_page.submit_valid_form_number
    national_insurance_page.submit_no
  end

  def ni_number
    to_fee_page
    fee_page.submit_fee_no
    form_name_page.submit_valid_form_number
    applying_on_behalf_page.submit_no
  end

  def benefits_change
    content.summary_row[5].action.click
  end

  def submit_application
    content.declaration_of_truth_checkbox.click
    content.submit_application_button.click
  end

  def stub_submission_request(response_status, response_body)
    WebMock.stub_request(:post, "#{ENV.fetch('SUBMISSION_URL', nil)}/api/submissions").
      with(headers: { Authorization: 'Token token=this_very_secret_token' }).
      to_return(status: response_status, body: response_body.to_json)
  end
end
