When(/^I open the home page$/) do
  home_page.load_page
  expect(home_page.content).to have_header
end

Then(/^I should see the home page$/) do
  expect(home_page.content).to have_eligibility
  expect(home_page.content).to have_savings
  expect(home_page.content).to have_benefits
  expect(home_page.content).to have_income
  expect(home_page.content).to have_apply
  expect(home_page.content).to have_other
end

Then(/^I should see the home page with error$/) do
  expect(home_page.content).to have_eligibility
  expect(home_page.content).to have_savings
  expect(home_page.content).to have_benefits
  expect(home_page.content).to have_income
  expect(home_page.content).to have_apply
  expect(home_page.content).to have_other
  expect(home_page.content).to have_error
end

When(/^I click the start button$/) do
  expect(home_page.content).to have_start_button
  home_page.content.start_button.click
end
