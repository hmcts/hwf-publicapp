Given(/^I am a single person with no children on income range page$/) do
  to_income_range_page_single
  expect(income_range_page.content).to have_step_info
  expect(income_range_page.content).to have_single_header
  expect(income_range_page.content).to have_select_single_income_hint
end

Given(/^I am a married person with no children on income range page$/) do
  to_income_range_page_married
  expect(income_range_page.content).to have_step_info
  expect(income_range_page.content).to have_married_header
  expect(income_range_page.content).to have_select_married_income_hint
end

Given(/^I am a married person with three children on income range page$/) do
  to_income_range_page_married_dependent_3
end

Given(/^I am a single person with three children on income range page$/) do
  to_income_range_page_single_dependent_3
end

When(/^I submit less than$/) do
  income_range_page.submit_less
end

And(/^I submit between$/) do
  income_range_page.submit_between
end

When(/^I submit more than$/) do
  income_range_page.submit_more
end

Then(/^I should see low income range '([^"]*)'$/) do |income|
  expect(income_range_page.content.income_label[0].text).to eq income
end

Then(/^I should see medium income range '([^"]*)'$/) do |income|
  expect(income_range_page.content.income_label[1].text).to eq income
end

Then(/^I should see high income range '([^"]*)'$/) do |income|
  expect(income_range_page.content.income_label[2].text).to eq income
end

Then(/^I should see the income list on step nine page:$/) do |incomes|
  incomes.rows.each_with_index do |income, index|
    expect(income_range_page.content.income[index].text).to eq income[0]
  end
end

Then(/^I should see select your monthly income error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(income_range_page.content).to have_blank_error_link
end

When(/^I should be taken to income range page$/) do
  expect(income_range_page).to be_displayed
end

When(/^I slowly submit less than$/) do
  income_range_page.slowly_submit_less
end
