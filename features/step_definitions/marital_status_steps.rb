Given(/^I am on the marital status page$/) do
  time = Time.zone.local(2026, 11, 28, 10, 5, 0)
  Timecop.freeze(time)
  to_marital_status
  Timecop.return
  expect(marital_status_page.content).to have_step_info
  expect(marital_status_page.content).to have_header
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
