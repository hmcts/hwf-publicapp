class NationalInsurancePresencePage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/national_insurance_presence'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 3 of 22'
    element :header, 'h1', text: 'Do you have a National Insurance number?'
    element :hint, 'div.govuk-hint', text: 'National Insurance numbers can be found on payslips or official letters about tax, pensions or benefits.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :where_to_find, 'summary', text: 'Find a lost National Insurance number'
    element :look_for_ni_text, 'li', text: 'look for your National Insurance number on payslips or official letters about tax, pensions or benefits'
    element :ask_for_reminder_link, 'a', text: 'ask for a reminder through the post'
    section :alert, 'div[role="alert"]' do
      element :blank_error_link, 'a.error-link'
    end
    element :invalid_error_link, 'a', text: 'is not included in the list'
  end

  def submit_yes
    national_insurance_presence_page.content.yes.click
    continue
  end

  def submit_no
    national_insurance_presence_page.content.no.click
    continue
  end

  def slowly_submit_yes
    travel 61.minutes do
      national_insurance_presence_page.content.yes.click
      continue
    end
  end
end
