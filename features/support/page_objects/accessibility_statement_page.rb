class AccessibilityStatementPage < BasePage
  set_url '/accessibility-statement'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Accessibility statement'
  end
end
