Given(/^I am on the summary page with probate enabled$/) do
  probate_enabled
  summary_page.to_summary_page_probate_enabled
  expect(summary_page).to be_displayed
  expect(summary_page.content).to have_step_info
  expect(summary_page.content).to have_header
  expect(summary_page.content).to have_check_details_hint
end

Given(/^I am on the summary page with probate disabled$/) do
  probate_disabled
  summary_page.to_summary_page_probate_disabled
  expect(summary_page.content).to have_step_info
  expect(summary_page.content).to have_header
  expect(summary_page.content).to have_check_details_hint
end

Given(/^I have a home office number but not a national insurance number$/) do
  probate_disabled
  summary_page.home_office_number
end

Then(/^I am on the summary page$/) do
  summary_page.to_summary_page_with_ho_number
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
