Given(/^I am on the summary page with probate enabled$/) do
  probate_enabled
  to_summary_page_probate_enabled
  expect(summary_page).to be_displayed
  expect(summary_page.content).to have_step_info
  expect(summary_page.content).to have_header
  expect(summary_page.content).to have_check_details_hint
end

Given(/^I am on the summary page with probate enabled and paid a fee$/) do
  probate_enabled
  to_summary_page_probate_enabled_fee_paid
end

Given(/^I am on the summary page with probate disabled$/) do
  probate_disabled
  to_summary_page_probate_disabled
  expect(summary_page.content).to have_step_info
  expect(summary_page.content).to have_header
  expect(summary_page.content).to have_check_details_hint
end

Given(/^I have a home office number but not a national insurance number$/) do
  probate_disabled
  summary_page.home_office_number
end

Then(/^I am on the summary page$/) do
  to_summary_page_with_ho_number
  expect(summary_page).to be_displayed
  expect(summary_page.content).to have_step_info
  expect(summary_page.content).to have_header
  expect(summary_page.content).to have_check_details_hint
end

Then(/^I should see my details:$/) do |scopes|
  scopes.rows.each_with_index do |scope, index|
    expect(summary_page.content.summary_row[index].text).to have_text scope[0]
  end
end

And(/^I should not see probate in the check details table$/) do
  expect(summary_page.content).to have_no_probate
end

Then(/^I should be able to go back and change my details:$/) do |urls|
  urls.rows.each_with_index do |url, index|
    expect(summary_page.content.summary_row[index].action['href']).to have_content url[0]
  end
end

Then(/^I should see probate in the check details table$/) do
  expect(summary_page.content).to have_probate
end

Then(/^I should see declaration of truth$/) do
  expect(summary_page.content).to have_declaration_of_truth
end

When(/^I click submit application and continue$/) do
  summary_page.submit_application
end

Then(/^I should be taken to summary page$/) do
  expect(summary_page).to be_displayed
end

And(/^I visit the start session path$/) do
  to_fee_page
  fee_page.submit_fee_yes
end

Then(/^I expect to have a blank form number$/) do
  form_name_page.should have_field("form_name[identifier]", text: "")
end

And(/^I change the benefit status$/) do
  summary_page.benefits_change
  expect(benefit_page).to be_displayed
  benefit_page.submit_benefit_no
end

And(/^I navigate back to the summary page using the browser back button$/) do
  page.go_back
  page.go_back
end

Then(/^I should see a changes notification\.$/) do
  expect(summary_page).to be_displayed
  expect(summary_page.content).to have_error
end

And(/^The submission service is down and I click continue$/) do
  summary_page.stub_submission_request(200, result: false, message: '')
  summary_page.submit_application
end

Then(/^They are redirected to the summary page with error message\.$/) do
  expect(summary_page.content).to have_header
end
