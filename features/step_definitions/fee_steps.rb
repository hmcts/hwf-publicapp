Given(/^I am on the fee page$/) do
  fee_page.to_fee_page
  expect(fee_page.content).to have_step_info
  expect(fee_page.content).to have_header
  expect(fee_page.content).to have_apply_for_refund
end

When(/^I submit no to have you already paid the fee$/) do
  fee_page.submit_fee_no
end

When(/^I select yes to have you already paid the fee$/) do
  fee_page.content.yes.click
end

And(/^I submit the form with a date thats within the last three months$/) do
  fee_page.valid_date
end

And(/^I submit the form with a date that exceeds three months$/) do
  fee_page.expired_date
end

When(/^I submit the form with a future date$/) do
  fee_page.future_date
end

When(/^I should see enter the fee date in this format error message$/) do
  expect(base_page.content).to have_there_is_a_problem
  expect(fee_page.content).to have_format_error_link
end

When(/^I should see select whether you've already paid the fee error message$/) do
  expect(base_page.content).to have_there_is_a_problem
  expect(fee_page.content).to have_blank_error_link
end

Then(/^I should see this date can't be in the future error message$/) do
  expect(base_page.content).to have_there_is_a_problem
  expect(fee_page.content).to have_future_date_error_link
end

Then(/^I should see the application must have been made in the last 3 months error message$/) do
  expect(base_page.content).to have_there_is_a_problem
  expect(fee_page.content).to have_expired_error_link
end
