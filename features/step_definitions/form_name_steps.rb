Given(/^I am on the form number page$/) do
  to_fee_page
  fee_page.submit_fee_yes
  expect(current_url).to have_content '/questions/form_name'
  expect(form_name_page.content).to have_step_info
  expect(form_name_page.content).to have_header
  expect(form_name_page.content).to have_enter_court_hint
end

Then(/^I should see probate applications not available warning message$/) do
  expect(form_name_page.content).to have_probate_warning_message
  expect(form_name_page.content).to have_probate_link
end

Then(/^I should not see probate applications not available warning message$/) do
  expect(form_name_page.content).to have_no_probate_warning_message
  expect(form_name_page.content).to have_no_probate_link
end

When(/^I submit the form with a valid form name$/) do
  submit_valid_form_name
end

When(/^I submit the form with a valid form number$/) do
  expect(form_name_page.content).to have_form_label
  form_name_page.submit_valid_form_number
end

When(/^I submit the form with I don’t have a form checked$/) do
  form_name_page.no_form
  continue
end

When(/^I submit the form without a number$/) do
  continue
end

Then(/^I should see more information about what to put in the form number field$/) do
  expect(form_name_page.content).to have_help_hearing_fees
end

Then(/^I should be taken to fee page$/) do
  expect(fee_page).to be_displayed
end

Then(/^I should see enter a number error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(form_name_page.content).to have_error_link
end

When(/^I submit the form with a help with fees form number '(.+?)'$/) do |num|
  form_name_page.form_name(num)
  continue
end

Then(/^I should see you entered the help with fees form number error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(form_name_page.content).to have_invalid_link
end

When(/^I submit the form with I don’t have a form checked after a long time$/) do
  form_name_page.no_form_long_time
  continue
end

When(/^I submit the form with a valid form number after a long time$/) do
  expect(form_name_page.content).to have_form_label
  form_name_page.submit_valid_form_number_long_time
end
