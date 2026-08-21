require 'axe/matchers/be_axe_clean'

# The Service Standard requires all services to meet level AA of the Web Content
# Accessibility Guidelines 2.2 (WCAG 2.2)
# [https://www.gov.uk/service-manual/helping-people-to-use-your-service/testing-for-accessibility]
WCAG_22_AA = %w[wcag2a wcag2aa wcag21a wcag21aa wcag22aa].freeze

def axe_clean_to_wcag_22_aa(exclude = nil)
  Axe::Matchers.be_axe_clean.according_to(WCAG_22_AA).excluding(*String(exclude).split(/,\s*/))
end

Then("the {string} page should meet accessibility standards") do |page_name|
  expect(base_page.content).to have_h1
  expect(page).to axe_clean_to_wcag_22_aa
  page.save_screenshot("../accessibility/screenshot-#{page_name}-#{Time.now.to_i}.png")
end

Then("the {string} page should meet accessibility standards excluding {string}") do |_page_name, exclude|
  expect(base_page.content).to have_h1
  expect(page).to axe_clean_to_wcag_22_aa(exclude)
end

And("the error summary on the {string} page should link to the fields in error") do |_page_name|
  expect(error_summary_page).to be_shown

  field_ids = error_summary_page.linked_field_ids
  expect(field_ids).to be_any

  field_ids.each do |id|
    expect(page).to have_selector(:id, id, visible: :all)
  end
end

And("the page should automatically focus on the error summary") do
  focused_element_selector = page.evaluate_script('document.activeElement.getAttribute("class")')

  expect(focused_element_selector).to include('govuk-error-summary')
end

Then("the {string} error page should meet accessibility standards") do |page_name|
  continue
  page.save_screenshot("../accessibility/screenshot-#{page_name}-error-#{Time.now.to_i}.png")
  expect(page).to axe_clean_to_wcag_22_aa

  # Verify the page automatically focuses on the error summary
  step "the page should automatically focus on the error summary"

  # Call the error summary check step
  step "the error summary on the \"#{page_name}\" page should link to the fields in error"
end

When("I open the cookies page") do
  cookie_page.load_page
end

Then("I should be on the cookies page") do
  expect(cookie_page.content).to have_header
end

When("I open the privacy policy page") do
  privacy_policy_page.load_page
end

Then("I should be on the privacy policy page") do
  expect(privacy_policy_page.content).to have_header
end

When("I open the terms and conditions page") do
  terms_and_conditions_page.load_page
end

Then("I should be on the terms and conditions page") do
  expect(terms_and_conditions_page.content).to have_header
end

When("I open the accessibility statement page") do
  accessibility_statement_page.load_page
end

Then("I should be on the accessibility statement page") do
  expect(accessibility_statement_page.content).to have_header
end

When("I open the technical help page") do
  technical_help_page.load_page
end

Then("I should be on the technical help page") do
  expect(technical_help_page.content).to have_header
end
