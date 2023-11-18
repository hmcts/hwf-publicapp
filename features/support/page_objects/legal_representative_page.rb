class LegalRepresentativePage < BasePage
  set_url '/questions/legal_representative'

  section :content, '#content' do
    element :header, 'h1', text: 'Are you a legal representative or litigation friend?'
    element :legal, 'label', text: 'Legal representative'
    element :friend, 'label', text: 'Litigation friend'
  end

  def legal_representative
    legal_representative_page.content.legal.click
    continue
  end

  def litigation_friend
    legal_representative_page.content.friend.click
    continue
  end

end
