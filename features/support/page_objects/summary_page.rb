class SummaryPage < BasePage
  set_url '/summary'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 21 of 22'
    element :header, 'h1', text: 'Check details'
    element :check_details_hint, 'p', text: 'Please check your details are correct. If you make changes, you may have to answer new questions and confirm information you’ve already entered.'
    element :probate, '.govuk-summary-list__row', text: 'Probate case No'
    element :declaration_of_truth, 'h2', text: 'Declaration and statement of truth'
    sections :summary_row, '.govuk-summary-list__row' do
      element :action, 'a', text: 'Change'
    end
    element :submit_application_button, 'input[value="Submit application and continue"]'
    element :error, '.govuk-error-message', text: 'You’ve made changes. Please answer the highlighted questions to complete your application.'
  end

  def home_office_number
    to_form_name
    form_name_page.submit_valid_form_number
    fee_page.submit_fee_no
    national_insurance_presence_page.submit_no
  end

  def benefits_change
    content.summary_row[5].action.click
  end

  def submit_application
    content.submit_application_button.click
  end

  def stub_submission_request(response_status, response_body)
    WebMock.stub_request(:post, "#{ENV['SUBMISSION_URL']}/api/submissions").
      with(headers: { Authorization: 'Token token=this_very_secret_token' }).
      to_return(status: response_status, body: response_body.to_json)
  end
end
