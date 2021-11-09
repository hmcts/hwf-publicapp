class HomeOfficePage < BasePage
  set_url '/questions/home_office?locale=en'

  section :content, '#content' do
    element :header, 'h1', text: 'What is your Home Office reference number?'
    element :step_info, '.govuk-caption-l', text: 'Step 5 of 22'
    element :hint, 'span.govuk-hint', text: 'For example, L1234567 or L1234567/1 (for family members) or 1111-2222-3333-4444 or 1111-2222-3333-4444/1 (for family members)'
    element :home_offce_number, '#home_office_ho_number'
    element :user_paper_form, 'p', text: "If you don't have either National Insurance number, or a Home Office reference number, you'll need to fill in the paper application form and apply to the court or tribunal by post or email."
    element :paper_form_link, 'a', text: 'paper application form'
    element :help_text, 'li', text: 'Your Home Office reference number can be found on any correspondence you have received from the Home Office'
    element :error_link, '.error-link', text: 'Enter a valid Home Office reference number'
    element :error_message, '.govuk-error-message', text: 'Enter a valid Home Office reference number'
    element :blank_error_link, '.error-link', text: 'Enter your Home Office reference number'
    element :blank_error_message, '.govuk-error-message', text: 'Enter your Home Office reference number'
  end

  def submit_valid_home_office_number
    home_office_page.content.home_offce_number.set '1212-0001-0240-0490/01'
    continue
  end

  def home_offce_number(str)
    content.home_offce_number.set str
  end
end
