class NationalInsurancePage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/national_insurance'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 7 of 25'
    element :header, 'h1', text: 'Do you have a National Insurance number?'
    element :national_insurance_text, 'div.govuk-hint', text: 'National Insurance numbers can be found on payslips or official letters about tax, pensions or benefits.'
    element :national_insurance_number, '#national_insurance_number'
    element :help_with_ni_dropdown, 'summary', text: 'If you don’t know your National Insurance number'
    element :look_for_ni_text, 'li', text: 'look for your National Insurance number on payslips or official letters about tax, pensions or benefits'
    element :ask_for_reminder_link, 'a', text: 'ask for a reminder through the post'
    element :no_ni_number_text, 'p', text: "If you don't have a National Insurance number, you need to"
    element :no_ni_number_link, 'a', text: "use the paper form"
    element :blank_error_link, 'a', text: 'Enter your National Insurance number'
    element :invalid_error_link, 'a', text: 'Enter a valid National Insurance number'
    element :lost_ni_number_text, 'li', text: 'look for your National Insurance number on payslips or official letters about tax, pensions or benefits'
    element :explanation, 'li', text: 'We may contact other government departments to validate the information you provide about you and your partner’s (if you have one) financial details. Providing this may reduce the likelihood of you having to provide further evidence before a decision is made.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
  end

  def submit_no
    national_insurance_page.content.no.click
    continue
  end

  def submit_valid_ni
    national_insurance_page.content.national_insurance_number.set('JL806367D')
    continue
  end

  def submit_invalid_ni
    national_insurance_page.content.national_insurance_number.set('01234%^&*')
    continue
  end

  def slowly_submit_valid_ni
    travel 61.minutes do
      select_yes_and_enter_valid_ni
    end
  end

  def select_yes_and_enter_valid_ni
    national_insurance_page.content.yes.click
    national_insurance_page.content.national_insurance_number.set('JL806367D')
    continue
  end

  def select_yes_and_enter_invalid_ni
    national_insurance_page.content.yes.click
    national_insurance_page.content.national_insurance_number.set('01234%^&*')
    continue
  end
end
