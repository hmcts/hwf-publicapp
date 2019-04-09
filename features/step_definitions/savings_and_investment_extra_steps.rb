And(/^I am single with £3,000 to £15,999 in savings$/) do
  savings_investment_extra_page.to_single_savings_extra
  expect(savings_investment_extra_page).to be_displayed
  expect(savings_investment_extra_page.content).to have_single_header
end

And(/^I am married with £3,000 to £15,999 in savings$/) do
  savings_investment_extra_page.to_married_savings_extra
  expect(savings_investment_extra_page).to be_displayed
  expect(savings_investment_extra_page.content).to have_married_header
end

When(/^I submit yes I am 61 years old or over$/) do
  savings_investment_extra_page.content.yes.click
  continue
end

When(/^I submit no to are you 61 years old or over$/) do
  savings_investment_extra_page.content.no.click
end

When(/^I enter £5000 as my savings and investments$/) do
  expect(savings_investment_extra_page.content).to have_how_much_label_single
  savings_investment_extra_page.content.extra_amount.set(5000)
end

When(/^I enter £1600 as our savings and investments$/) do
  expect(savings_investment_extra_page.content).to have_how_much_label_married
  savings_investment_extra_page.content.extra_amount.set(1600)
end

Then(/^I should see enter amount between error message$/) do
  expect(common_page.content).to have_there_is_a_problem
  expect(savings_investment_extra_page.content).to have_error_message
  expect(savings_investment_extra_page.content).to have_error_link
end

Then(/^I should see enter how much you have in savings and investments error message$/) do
  expect(common_page.content).to have_there_is_a_problem
  expect(savings_investment_extra_page.content).to have_blank_error_message
  expect(savings_investment_extra_page.content).to have_blank_error_link
end

Then(/^I should be taken to savings and investment extra page$/) do
  expect(savings_investment_extra_page).to be_displayed
end
