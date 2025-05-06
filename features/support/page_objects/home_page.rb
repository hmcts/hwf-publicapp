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
    element :start_button, 'a', text: 'Start now'
    element :fees_link, 'a', text: 'Court and tribunal fees'
    element :adjournment_link, 'a', text: 'adjournment fees for certain civil and family hearings'
    element :welsh_guide_link, 'a', text: 'in Welsh (Cymraeg)'
    element :eligible_link, 'a', text: 'Check if you\'re eligible'
    element :paper_form_link, 'a', text: 'Fill in a paper form'
    element :paper_form_link2, 'a', text: 'filling in a paper form'
  end
end
