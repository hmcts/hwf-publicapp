Given(/^I am on the confirmation page with probate enabled$/) do
  probate_enabled
  to_confirmation_page
  expect(confirmation_page).to be_displayed
  expect(confirmation_page.content).to have_step_info
  expect(confirmation_page.content).to have_header
  expect(confirmation_page.content).to have_confirmation_header
end

Given(/^I am on the confirmation page$/) do
  to_confirmation_page
  expect(confirmation_page).to be_displayed
  expect(confirmation_page.content).to have_step_info
  expect(confirmation_page.content).to have_header
  expect(confirmation_page.content).to have_confirmation_header
end

Then(/^I should see instruction points$/) do
  expect(confirmation_page.content.list).to have_one
  expect(confirmation_page.content.list).to have_two
  expect(confirmation_page.content.list).to have_three
  expect(confirmation_page.content.list).to have_four
end

Then(/^I should be taken to confirmation page$/) do
  expect(confirmation_page).to be_displayed
end
