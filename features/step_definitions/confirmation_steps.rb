Given(/^I am on the paper confirmation page with probate enabled$/) do
  probate_enabled
  to_confirmation_page
  expect(confirmation_page).to be_displayed
  expect(confirmation_page.content).to have_step_info
  expect(confirmation_page.content).to have_header
  expect(confirmation_page.content).to have_confirmation_header_paper_one
  expect(confirmation_page.content).to have_confirmation_header_paper_two
end

Given(/^I am on the online confirmation page with probate enabled$/) do
  probate_enabled
  to_online_confirmation_page
  expect(confirmation_page).to be_displayed
  expect(confirmation_page.content).to have_step_info
  expect(confirmation_page.content).to have_header
  expect(confirmation_page.content).to have_confirmation_header_online_one
  expect(confirmation_page.content).to have_confirmation_header_online_two
end

Then(/^I should see instruction points$/) do
  expect(confirmation_page.content).to have_confirmation_instruction_line_one
  expect(confirmation_page.content).to have_confirmation_instruction_line_two

  expect(confirmation_page.content.list).to have_one
  expect(confirmation_page.content.list).to have_two
  expect(confirmation_page.content.list).to have_three
end

Then('I should see online instruction points') do
  expect(confirmation_page.content).to have_confirmation_instruction_online

end

And(/^I should see next steps$/) do
  expect(confirmation_page.content).to have_next_step
  expect(confirmation_page.content).to have_feedback_text
end

Then('I should see online next steps') do
  expect(confirmation_page.content).to have_next_step_online
  expect(confirmation_page.content).to have_feedback_text
end

When(/^I click the finish application button$/) do
  confirmation_page.submit
end

Then(/^I should be taken to the survey page$/) do
  survey_url = Rails.application.config.finish_page_redirect_url
  expect(current_path).to eq survey_url
end

Then(/^I should be taken to confirmation page$/) do
  expect(confirmation_page).to be_displayed
  expect(confirmation_page.content).to have_step_info
  expect(confirmation_page.content).to have_header
end

Then(/^I should be taken to confirmation page about refund$/) do
  expect(confirmation_page_refund).to be_displayed
  expect(confirmation_page_refund.content).to have_step_info
  expect(confirmation_page_refund.content).to have_header
end

