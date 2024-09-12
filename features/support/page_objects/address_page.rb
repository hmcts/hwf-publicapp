class AddressPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/applicant_address'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 21 of 25'
    element :header, 'h1', text: 'What is your address?'
  end

  def submit_full_address
    address_page.street('102 Petty France')
    address_page.town('London')
    address_page.post_code('SW1H 9AJ')
    continue
  end

  def submit_full_address_demo
    click_link 'Enter address manually'
    address_page.street('102 Petty France')
    address_page.town('London')
    address_page.post_code('SW1H 9AJ')
    continue
  end

  def street(str)
    fill_in 'House number and street', with: str
  end

  def town(str)
    fill_in 'Town or City', with: str
  end

  def post_code(str)
    fill_in 'Postcode', with: str
  end

  def slow_submit_full_address
    travel 61.minutes do
      address_page.street('102 Petty France')
      address_page.town('London')
      address_page.post_code('SW1H 9AJ')
      continue
    end
  end
end
