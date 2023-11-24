Given(/^I am on the marital status page$/) do
  to_marital_status
  expect(marital_status_page.content).to have_step_info
  expect(marital_status_page.content).to have_header
end

Given(/^I am on the marital status page ucd$/) do
  to_marital_status_ucd
  expect(marital_status_page.content).to have_step_info_ucd
  expect(marital_status_page.content).to have_header_ucd
  expect(marital_status_page.content).to have_subheader
  expect(marital_status_page.content).to have_single_header
  expect(marital_status_page.content).to have_married_header
  expect(marital_status_page.content).to have_single_point_1
  expect(marital_status_page.content).to have_single_point_2
  expect(marital_status_page.content).to have_single_point_3
  expect(marital_status_page.content).to have_married_point_1
  expect(marital_status_page.content).to have_married_point_2
  expect(marital_status_page.content).to have_married_point_3
end

When(/^I submit the form as single$/) do
  marital_status_page.submit_single
end

When(/^I submit the form as married$/) do
  marital_status_page.submit_married
end

Then(/^I should see help with status copy$/) do
  expect(marital_status_page.content).to have_help_choose_married
  expect(marital_status_page.content).to have_help_married
  expect(marital_status_page.content).to have_help_civil_partners
  expect(marital_status_page.content).to have_help_living_together
  expect(marital_status_page.content).to have_help_same_address
  expect(marital_status_page.content).to have_help_live_apart
  expect(marital_status_page.content).to have_help_choose_single
  expect(marital_status_page.content).to have_help_divorce
  expect(marital_status_page.content).to have_help_gender
  expect(marital_status_page.content).to have_help_domestic_violence
  expect(marital_status_page.content).to have_help_forced_marriage
  expect(marital_status_page.content).to have_help_dissolution
end

Then(/^I should see help with status copy ucd$/) do
  expect(marital_status_page.content).to have_help_text
end

Then(/^I should be taken to marital status page$/) do
  expect(marital_status_page).to be_displayed
end

When(/^I slowly submit the form as single$/) do
  marital_status_page.slowly_submit_single
end

When(/^I slowly submit the form as married or living with someone and sharing an income$/) do
  marital_status_page.slowly_submit_partnered
end
