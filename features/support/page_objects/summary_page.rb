class SummaryPage < BasePage
  set_url '/summary'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 20 of 22'
    element :header, 'h1', text: 'Check details'
    element :check_details_hint, 'p', text: 'Please check your details are correct. If you make changes, you may have to answer new questions and confirm information you’ve already entered.'
    element :probate, '.govuk-summary-list__row', text: 'Probate case No'
    element :declaration_of_truth, 'h2', text: 'Declaration and statement of truth'
    sections :summary_row, '.govuk-summary-list__row' do
      element :action, 'a', text: 'Change'
    end
    element :submit_application_button, 'input[value="Submit application and continue"]'
  end

  def home_office_number
    to_form_name
    form_name_page.submit_valid_form_number
    fee_page.submit_fee_no
    national_insurance_presence_page.submit_no
  end

  def submit_application
    content.submit_application_button.click
  end
end
