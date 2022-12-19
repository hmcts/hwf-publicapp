Given(/^I am a single person on income amount page$/) do
  to_income_amount_single
  expect(income_amount_page.content).to have_step_info
  expect(income_amount_page.content).to have_single_header
  expect(income_amount_page.content).to have_hint_text_single
end

Given(/^I am a married person on income amount page$/) do
  to_income_amount_married
  expect(income_amount_page.content).to have_step_info
  expect(income_amount_page.content).to have_married_header
  expect(income_amount_page.content).to have_hint_text_married
end

When(/^I submit the form with my monthly income$/) do
  income_amount_page.income(1900)
  continue
end

Then(/^I should see the income list on step ten page:$/) do |incomes|
  your_income = income_amount_page.content.income_list
  incomes.rows.each_with_index do |income, index|
    expect(your_income.li[index].text).to eq income[0]
  end
end

Then(/^I should see enter how much income do you receive error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(income_amount_page.content).to have_blank_error_link
end

Then(/^I should be taken to income amount page$/) do
  expect(income_amount_page).to be_displayed
end
