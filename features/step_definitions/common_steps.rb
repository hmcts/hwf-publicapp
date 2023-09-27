def group_common(index)
  base_page.content.form_group[index]
end

When(/^I see the are you sure copy$/) do
  expect(base_page.restart_confirm).to have_yes_button
  expect(base_page.restart_confirm).to have_are_you_sure
  expect(base_page.restart_confirm).to have_if_you_cancel
end

When(/^I click continue$/) do
  continue
end

When(/^I click on '([^"]*)'$/) do |help|
  expect(base_page.help_with.text).to have_content help
  base_page.click_help_with
end

Then(/^I should see '([^"]*)' header$/) do |header|
  expect(base_page.content.h1.text).to have_content header
end

Then(/^I am taken to the Help with Fees homepage$/) do
  expect(current_path).to eq '/'
end

Then(/^I should see step (\d+) of 20$/) do |step_number|
  expect(base_page.content.step_number.text).to eq "Step #{step_number} of 20"
end

Then(/^I should not see the cancel application options$/) do
  expect(base_page).to_not have_restart_confirm
end

Then(/^I should remain on the page$/) do
  expect(current_path).to eq '/questions/form_name'
end

Then(/^I should see hint '([^"]*)'$/) do |hint|
  hint_group = base_page.content.text.p[0]
  expect(hint_group.text).to have_content hint
end

Then(/^I should see single person hint '([^"]*)'$/) do |hint|
  hint_group = base_page.content.text.p[0]
  expect(hint_group.text).to have_content hint
end

Then(/^I should see married person hint '([^"]*)'$/) do |hint|
  hint_group = base_page.content.text.p[0]
  expect(hint_group.text).to have_content hint
end

Then(/^I should see save or print this page$/) do
  expect(base_page.js_print['href']).to end_with '#'
  expect(base_page.js_print.text).to eq 'Save or print this page'
end

Then(/^I should see '([^"]*)' error message$/) do |error_message|
  expect(base_page.content.alert).to have_there_is_a_problem
  error_summary_group = base_page.error_summary
  expect(error_summary_group).to have_error_summary_heading
  expect(error_summary_group.link.text).to have_content error_message
  expect(base_page.error_message[0].text).to have_content error_message
end

Then(/^I should see average monthly income copy$/) do
  average_income = base_page.content.text.p[1]
  expect(average_income.text).to have_content 'work out an average monthly income'
end

And(/^I click the '(.*)' link$/) do |string|
  click_on(string)
end