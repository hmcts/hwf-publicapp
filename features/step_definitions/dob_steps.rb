Given(/^I am on the date of birth page$/) do
  to_dob_page
  expect(dob_page.content).to have_step_info
  expect(dob_page.content).to have_header
  expect(dob_page.content).to have_dob_hint
end

When(/^I enter a valid date of birth$/) do
  dob_page.valid_dob
end

When(/^I enter a date of less than fifteen years$/) do
  dob_page.under_age_dob
end

And(/^I enter an invalid date of birth$/) do
  dob_page.over_age_dob
end

Then(/^I should see this format hint$/) do
  expect(dob_page.hint.text).to eq 'Use this format D D / M M / Y Y Y Y'
end

Then(/^I should see you must be over 15 to use this service error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(dob_page.content).to have_under_age_error_link
end

Then(/^I should see check this date of birth is correct error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(dob_page.content).to have_over_age_error_link
end

Then(/^I should see enter the date of birth in this format error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(dob_page.content).to have_blank_error_link
end

Then(/^I should be taken to date of birth page$/) do
  expect(dob_page).to be_displayed
end

When(/^I slowly enter a valid date of birth$/) do
  dob_page.slow_dob_entry
end

When(/^I enter a date of birth "(.*)\/(.*)\/(.*)"$/) do |day, month, year|
  dob_page.content.dob_day.set(day)
  dob_page.content.dob_month.set(month)
  dob_page.content.dob_year.set(year)
  continue
end