class LegalRepresentativeDetailPage < BasePage
  set_url '/questions/legal_representative_detail'

  section :content, '#content' do
    element :header, 'h1', text: 'Enter the legal representative details'
    element :legal, 'label', text: 'Legal representative'
  end

  def fill_in_mandatory_fields
    fill_in 'First name', with: 'Tom'
    fill_in 'Last name', with: 'Jones'
    fill_in 'Email address', with: 'tom@jones.com'
    fill_in 'House number and street', with: 'London road'
    fill_in 'Town or City', with: 'Bath'
    fill_in 'Postcode', with: 'ABC132'

    continue
  end

end
