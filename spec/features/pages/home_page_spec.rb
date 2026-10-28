require 'rails_helper'

RSpec.feature 'Landing page languages' do
  scenario 'the English page links to the Welsh version and back' do
    visit root_path(locale: :en)
    expect(page).to have_css('h1', text: 'Get help paying court and tribunal fees')

    click_link 'in Welsh (Cymraeg)'
    expect(page).to have_css('h1', text: 'Help i dalu ffioedd llysoedd a thribiwnlysoedd')
    expect(page).to have_css('h2', text: 'Cynnwys cysylltiedig')
    expect(page).to have_link('Dechrau nawr', href: checklist_path(locale: :cy))

    click_link 'yn Saesneg (English)'
    expect(page).to have_css('h1', text: 'Get help paying court and tribunal fees')
  end
end
