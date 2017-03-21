Given(/^I visit the page for step eleven - Are you paying a fee for a probate case\?$/) do
  answer_up_to_income_amount_married
  step 'I submit the form with my monthly income'
  expect(probate_page.content).to have_step_info
  expect(probate_page.content).to have_probate_header
  expect(probate_page.content).to have_probate_hint
end

When(/^I select no to are you paying a fee for a probate case$/) do
  probate_page.submit_no
end

When(/^I select yes to are you paying a fee for a probate case$/) do
  probate_page.answer_yes
  continue
end

When(/^I enter the name of deceased$/) do
  expect(probate_page.content).to have_name_of_deceased
  probate_page.deceased_name
end

When(/^I enter a valid date of death$/) do
  probate_page.valid_date_of_death
end

When(/^I enter a date over twenty years ago$/) do
  probate_page.answer_yes
  probate_page.deceased_name
  probate_page.date_of_death_over_20_years
end

When(/^I enter a invalid date of death$/) do
  probate_page.answer_yes
  probate_page.deceased_name
  probate_page.invalid_date_of_death
end

When(/^I enter a future date of death$/) do
  probate_page.answer_yes
  probate_page.deceased_name
  probate_page.future_date_of_death
end

Then(/^I should see error message this date can't be in the future$/) do
  expect(probate_page.content).to have_future_date_error_message
  expect(probate_page.content).to have_future_date_error_link
end

Then(/^I should see error message the date of death must have been in the last 20 years$/) do
  expect(probate_page.content).to have_expired_date_error_message
  expect(probate_page.content).to have_expired_date_error_link
end

Then(/^I should see enter the date in this format error message$/) do
  expect(probate_page.content).to have_invalid_date_error_message
  expect(probate_page.content).to have_invalid_date_error_link
end

Then(/^I should see select whether you're paying a fee for a probate case error message$/) do
  expect(probate_page.content).to have_blank_error_message
  expect(probate_page.content).to have_blank_error_link
end