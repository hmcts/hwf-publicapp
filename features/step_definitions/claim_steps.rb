Given(/^I am '([^"]*)' and on the claim page$/) do |status|
  status == 'married' ? to_claim_page_married : to_claim_page_single
  expect(claim_page).to be_displayed
  expect(claim_page.content).to have_step_info
  expect(claim_page.content).to have_header
  expect(claim_page.content).to have_claim_text
end

When(/^I select no to do you have a case, claim or notice to pay number$/) do
  claim_page.submit_claim_no
end

When(/^I select yes to do you have a case, claim or notice to pay number$/) do
  claim_page.submit_claim_yes
end

When(/^I enter a case, claim or notice to pay number$/) do
  expect(claim_page.content).to have_claim_number_label
  claim_page.input_field('012345678')
  continue
end

Then(/^I should see help with case number copy$/) do
  expect(claim_page.content).to have_creates_reference_number_copy
  expect(claim_page.content).to have_ongoing_case_copy
  expect(claim_page.content).to have_dont_have_reference_number_copy
end

Then(/^I should see enter a case, claim or ‘notice to pay’ number error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(claim_page.content).to have_enter_number_error_link
end

Then(/^I should see select whether you have a case, claim or ‘notice to pay’ error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(claim_page.content).to have_blank_error_link
end

And(/^I enter a long case, claim or notice to pay number$/) do
  expect(claim_page.content).to have_claim_number_label
  claim_page.input_field('abcdefghijklmnopqrstuvwxyz')
  continue
end

And(/^I enter a case, claim or notice to pay number after a long time$/) do
  claim_page.slow_claim_number_entry
end

When(/^I slowly select no to do you have a case, claim or notice to pay number$/) do
  claim_page.slow_no_option
end
