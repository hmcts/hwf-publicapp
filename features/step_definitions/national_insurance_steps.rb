Given(/^I am on the national insurance page$/) do
  to_national_insurance_page
  expect(national_insurance_page.content).to have_step_info
  expect(national_insurance_page.content).to have_header
  expect(national_insurance_page.content).to have_national_insurance_text
end

When(/^I submit a valid national insurance number$/) do
  national_insurance_page.submit_valid_ni
end

And(/^I submit an invalid national insurance number$/) do
  national_insurance_page.submit_invalid_ni
end

Then(/^I should see if you don't know your national insurance number copy$/) do
  expect(national_insurance_page.content).to have_look_for_ni_text
  expect(national_insurance_page.content.ask_for_reminder_link['href']).to eq 'https://www.gov.uk/lost-national-insurance-number'
  expect(national_insurance_page.content).to have_no_ni_number_text
  expect(national_insurance_page.content).to have_no_ni_number_link
end

Then(/^I should see enter a valid National Insurance number error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(national_insurance_page.content).to have_invalid_error_link
end

Then(/^I should be taken to national insurance page$/) do
  expect(national_insurance_page).to be_displayed
end

When(/^I slowly submit a valid national insurance number$/) do
  national_insurance_page.slowly_submit_valid_ni
end
