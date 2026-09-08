class TechnicalHelpPage < BasePage
  set_url '/ask-for-help'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Ask for technical help'
  end
end
