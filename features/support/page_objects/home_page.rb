class HomePage < BasePage
  set_url '/'

  section :content, '#main-content' do
    element :header, 'h1', text: 'Get help paying court and tribunal fees'
    element :eligibility, 'h2', text: 'Eligibility'
    element :savings, 'h3', text: 'Your savings'
    element :benefits, 'h3', text: 'Benefits you get'
    element :income, 'h3', text: 'Your income'
    element :apply, 'h3', text: 'Apply online'
    element :other, 'h3', text: 'Apply by post'
    element :error, 'h2', text: 'There is a problem'
    element :start_button, 'a', text: 'Start now'
    element :fees_link, 'a', text: 'Court and tribunal fees'
    element :welsh_guide_link, 'a', text: 'in Welsh (Cymraeg)'
    element :guidance_link, 'a', text: 'Read further guidance', match: :first
    element :cop_form_link, 'a', text: 'form COP44A'
    element :paper_form_link, 'a', text: 'form EX160'
  end
end
