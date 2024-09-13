Given(/^I am a single person on the savings and investments page$/) do
  to_single_savings
  expect(savings_investment_page).to be_displayed
  expect(savings_investment_page.content).to have_step_info
  expect(savings_investment_page.content).to have_header
  expect(savings_investment_page.content).to have_hint_text
end

Given(/^I am a single person on the savings and investments page ucd$/) do
  to_single_savings_ucd
  expect(savings_investment_page).to be_displayed
  expect(savings_investment_page.content).to have_step_info
  expect(savings_investment_page.content).to have_header_ucd
  expect(savings_investment_page.content).to have_single_reminder
end

Given(/^I am a married person on the savings and investments page$/) do
  to_married_savings
  expect(savings_investment_page).to be_displayed
  expect(savings_investment_page.content).to have_step_info
  expect(savings_investment_page.content).to have_header
  expect(savings_investment_page.content).to have_married_reminder
end

Given(/^I am a married person on the savings and investments page ucd$/) do
  to_married_savings_ucd
  expect(savings_investment_page).to be_displayed
  expect(savings_investment_page.content).to have_step_info
  expect(savings_investment_page.content).to have_header_ucd
  expect(savings_investment_page.content).to have_married_reminder_ucd
end

When(/^I submit the form with less than £4,250 checked$/) do
  savings_investment_page.low_amount_checked_ucd
end

When(/^I submit the form with between £4,250 and £15,999 checked$/) do
  savings_investment_page.medium_amount_checked_ucd
end

When(/^I submit the form with £16,000 or more checked$/) do
  savings_investment_page.high_amount_checked
end

Then(/^I should see include with savings and investments copy$/) do
  expect(savings_investment_page.content).to have_include_text
end

Then(/^I should see help with savings and investments copy$/) do
  expect(savings_investment_page.content).to have_help_text
end

Then(/^I should be taken to benefits page$/) do
  expect(benefit_page).to be_displayed
end

Then(/^I should be taken to savings and investments page$/) do
  expect(savings_investment_page).to be_displayed
end

When(/^I slowly submit the form with £16,000 or more checked$/) do
  savings_investment_page.slowly_high_amount_checked
end

When(/^I slowly submit the form with £3,000 to £15,999 or more checked$/) do
  savings_investment_page.slowly_mid_amount_checked
end

When(/^I slowly submit the form with £0 to £2,999 or more checked$/) do
  savings_investment_page.slowly_low_amount_checked
end

When(/^I slowly submit the form with between £4,250 and £15,999 or more checked$/) do
  savings_investment_page.slowly_mid_amount_checked_ucd
end

When(/^I slowly submit the form with less than £4,250 or more checked$/) do
  savings_investment_page.slowly_low_amount_checked_ucd
end
