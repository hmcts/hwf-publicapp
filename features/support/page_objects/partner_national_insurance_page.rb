class PartnerNationalInsurancePage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/partner_national_insurance'

  section :content, '#content' do
    element :header, 'h1', text: "Enter your partner's National Insurance number"
    element :national_insurance_text, 'div.govuk-hint', text: 'For example, QQ123456C'
    element :national_insurance_number, 'input[name="partner_national_insurance[number]"]'
    element :partner_ni_number_blank, 'label', text: 'My partner does not have a National Insurance number'
  end

  def submit_valid_ni
    content.national_insurance_number.set('JL806367A')
    continue
  end

  def submit_no_ni
    content.partner_ni_number_blank.click
    continue
  end

end
