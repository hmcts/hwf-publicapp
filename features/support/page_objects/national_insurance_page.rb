class NationalInsurancePage < BasePage
  set_url '/questions/national_insurance'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 4 of 22'
    element :header, 'h1', text: 'Enter National Insurance number'
    element :national_insurance_text, 'span.govuk-hint', text: 'For example, QQ123456C'
    element :national_insurance_number, '#national_insurance_number'
    element :help_with_ni_dropdown, 'summary', text: 'If you don’t know your National Insurance number'
    element :look_for_ni_text, 'li', text: 'look for your National Insurance number on payslips or official letters about tax, pensions or benefits'
    element :ask_for_reminder_link, 'a', text: 'ask for a reminder through the post'
    element :no_ni_number_text, 'p', text: "If you don't have a National Insurance number, you need to"
    element :no_ni_number_link, 'a', text: "use the paper form"
    element :blank_error_link, 'a', text: 'Enter your National Insurance number'
    element :invalid_error_link, 'a', text: 'Enter a valid National Insurance number'
  end

  def submit_valid_ni
    national_insurance_page.content.national_insurance_number.set('JL806367D')
    continue
  end

  def submit_invalid_ni
    national_insurance_page.content.national_insurance_number.set('012345678')
    continue
  end
end
