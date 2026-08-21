class PrivacyPolicyPage < BasePage
  set_url '/privacy-policy'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Privacy policy'
  end
end
