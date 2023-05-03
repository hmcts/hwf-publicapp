Given(/^I am on the national insurance presence page$/) do
  to_national_insurance_presence_page
  expect(national_insurance_presence_page.content).to have_step_info
  expect(national_insurance_presence_page.content).to have_header
  expect(national_insurance_presence_page.content).to have_hint
end

Then(/^I should be taken to national insurance presence page$/) do
  expect(national_insurance_presence_page).to be_displayed
  expect(national_insurance_presence_page.content).to have_header
end

When("I have a national insurance number") do
  national_insurance_presence_page.submit_yes
end

When("I do not have a national insurance number") do
  national_insurance_presence_page.submit_no
end

Then("I should be taken to the home office page") do
  expect(home_office_page).to be_displayed
end

Then("I should see further information with a link to ask for a reminder") do
  expect(national_insurance_presence_page.content).to have_where_to_find
  expect(national_insurance_presence_page.content).to have_look_for_ni_text
  expect(national_insurance_presence_page.content.ask_for_reminder_link['href']).to end_with '/lost-national-insurance-number'
end

Then(/^I should see enter your national insurance number error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(national_insurance_presence_page.content.alert).to have_blank_error_link
end

When(/^I slowly select that I do have a national insurance number$/) do
  national_insurance_presence_page.slowly_submit_yes
end