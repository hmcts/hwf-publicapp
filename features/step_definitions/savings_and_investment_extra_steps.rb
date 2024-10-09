And(/^I am single with £3,000 to £15,999 in savings$/) do
  to_single_savings_extra
  expect(savings_investment_extra_page).to be_displayed
  expect(savings_investment_extra_page.content).to have_single_header
end

And(/^I am single with between £4,250 and £15,999 in savings$/) do
  to_single_savings_extra_ucd
  expect(savings_investment_extra_page).to be_displayed
  expect(savings_investment_extra_page.content).to have_single_header_ucd
end

And(/^I am married with £3,000 to £15,999 in savings$/) do
  to_married_savings_extra
  expect(savings_investment_extra_page).to be_displayed
  expect(savings_investment_extra_page.content).to have_married_header
end

And(/^I am married with between £4,250 and £15,999 in savings$/) do
  to_married_savings_extra_ucd
  expect(savings_investment_extra_page).to be_displayed
  expect(savings_investment_extra_page.content).to have_married_header_ucd
end

When(/^I submit yes I am 61 years old or over$/) do
  savings_investment_extra_page.submit_yes
end

When(/^I submit no to are you 61 years old or over$/) do
  savings_investment_extra_page.submit_no
end

When(/^I submit yes I am 66 years old or over$/) do
  savings_investment_extra_page.submit_yes
end

When(/^I submit no to are you 66 years old or over$/) do
  savings_investment_extra_page.submit_no
end

When(/^I enter £1600 as my savings and investments$/) do
  expect(savings_investment_extra_page.content).to have_how_much_label_single
  savings_investment_extra_page.content.extra_amount.set(1600)
end

When(/^I enter £5000 as my savings and investments$/) do
  expect(page).to have_text 'Rounded to the nearest £'
  expect(savings_investment_extra_page.content).to have_how_much_label_single
  savings_investment_extra_page.content.extra_amount.set(5000)
end

When(/^I enter £5000 as my savings and investments ucd$/) do
  expect(page).to have_text 'Rounded to the nearest £'
  expect(savings_investment_extra_page.content).to have_how_much_label_single_ucd
  savings_investment_extra_page.content.extra_amount.set(5000)
end

When(/^I enter £1600 as our savings and investments$/) do
  expect(savings_investment_extra_page.content).to have_how_much_label_married
  savings_investment_extra_page.content.extra_amount.set(1600)
end

When(/^I enter £1600 as our savings and investments ucd$/) do
  expect(savings_investment_extra_page.content).to have_how_much_label_married_ucd
  savings_investment_extra_page.content.extra_amount.set(1600)
end

When(/^I enter £5000 as our savings and investments$/) do
  expect(savings_investment_extra_page.content).to have_how_much_label_married
  savings_investment_extra_page.content.extra_amount.set(5000)
end

Then(/^I should see enter amount between error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(savings_investment_extra_page.content).to have_error_link
end

Then(/^I should see enter amount between error message ucd$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(savings_investment_extra_page.content).to have_error_link_ucd
end

Then(/^I should see enter how much you have in savings and investments error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(savings_investment_extra_page.content).to have_blank_error_link
end

Then(/^I should be taken to savings and investment extra page$/) do
  expect(savings_investment_extra_page).to be_displayed
end

When(/^I slowly submit yes I am 61 years old or over$/) do
  savings_investment_extra_page.slowly_submit_yes
end

When(/^I slowly submit no I am not 61 years old or over$/) do
  savings_investment_extra_page.slowly_submit_no
end

When(/^I slowly submit yes I am 66 years old or over$/) do
  savings_investment_extra_page.slowly_submit_yes
end

When(/^I slowly submit no I am not 66 years old or over$/) do
  savings_investment_extra_page.slowly_submit_no
end

When('I should see partner NI page') do
  expect(partner_national_insurance_page.content).to have_header
  partner_national_insurance_page.submit_no_ni
end
