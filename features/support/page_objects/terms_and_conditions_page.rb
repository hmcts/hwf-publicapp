class TermsAndConditionsPage < BasePage
  set_url '/terms_and_conditions'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Terms and conditions'
  end
end
