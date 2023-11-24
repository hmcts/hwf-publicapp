class PartnerNationalInsurancePage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/national_insurance'

  section :content, '#content' do
    element :header, 'h1', text: 'Enter National Insurance number'
    element :national_insurance_text, 'div.govuk-hint', text: 'For example, QQ123456C'
    element :national_insurance_number, 'partner_national_insurance[number]'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
  end

  def submit_valid_ni
    partner_national_insurance_page.content.no.click
    # partner_national_insurance_page.content.national_insurance_number
    # find_field('partner_national_insurance[number]', visible: false).set('JL806367D')
    continue
  end

  def submit_no_ni
    partner_national_insurance_page.content.no.click
    continue
  end

end
