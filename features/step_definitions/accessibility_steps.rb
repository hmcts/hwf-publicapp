require 'axe/matchers/be_axe_clean'

# The Service Standard requires all services to meet level AA of the Web Content
# Accessibility Guidelines 2.2 (WCAG 2.2)
# [https://www.gov.uk/service-manual/helping-people-to-use-your-service/testing-for-accessibility]
WCAG_22_AA = ['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa', 'wcag22aa'].freeze

def axe_clean_to_wcag_22_aa(exclude = nil)
  Axe::Matchers.be_axe_clean.according_to(WCAG_22_AA).excluding(*String(exclude).split(/,\s*/))
end

Then("the {string} page should meet accessibility standards") do |_page_name|
  expect(page).to axe_clean_to_wcag_22_aa
end

Then("the {string} page should meet accessibility standards excluding {string}") do |_page_name, exclude|
  expect(page).to axe_clean_to_wcag_22_aa(exclude)
end

And("the error summary on the {string} page should link to the fields in error") do |_page_name|
  expect(error_summary_page).to be_shown

  field_ids = error_summary_page.linked_field_ids
  expect(field_ids).to be_any

  field_ids.each do |id|
    expect(page).to have_css("##{id}", visible: :all)
  end
end