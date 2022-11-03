class HomePage < BasePage
  set_url '/'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Get help paying court and tribunal fees'
    element :eligibility, 'h2', text: 'Eligibility'
    element :savings, 'h3', text: 'Savings'
    element :benefits, 'h3', text: 'Benefits'
    element :income, 'h3', text: 'Income'
    element :apply, 'h2', text: 'Apply online'
    element :other, 'h2', text: 'Other ways to apply'
    element :error, 'h2', text: 'There is a problem'
  end
end
