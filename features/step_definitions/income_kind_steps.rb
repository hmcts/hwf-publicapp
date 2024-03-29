Given(/^I am a single person on kind of income page$/) do
  to_income_kind_single
  expect(income_kind_page.content).to have_choose_income_single
  # expect(income_kind_page.content).to have_step_info
  expect(income_kind_page.content).to have_single_header
end

Given(/^I am a single person on kind of income page ucd$/) do
  to_income_kind_single_ucd
  expect(income_kind_page.content).to have_choose_income_single_ucd
  expect(income_kind_page.content).to have_representative_hint_single
  # expect(income_kind_page.content).to have_step_info_ucd
  expect(income_kind_page.content).to have_single_header_ucd
end

Given(/^I am a married person on kind of income page$/) do
  to_income_kind_married
  expect(income_kind_page.content).to have_choose_income_married
  # expect(income_kind_page.content).to have_step_info
  expect(income_kind_page.content).to have_married_header
end

Given(/^I am a married person on kind of income page ucd$/) do
  to_income_kind_married_ucd
  expect(income_kind_page.content).to have_choose_income_married_ucd
  expect(income_kind_page.content).to have_representative_hint_married
  # expect(income_kind_page.content).to have_step_info_ucd
  expect(income_kind_page.content).to have_married_header_ucd
end

When(/^I submit the form with none of the above checked$/) do
  income_kind_page.submit_none_of_the_above
end

When(/^I submit the form with no income checked$/) do
  income_kind_page.submit_no_income
end

When(/^I submit the form with wages checked$/) do
  income_kind_page.submit_single_income_wages_tax_credit
end

When(/^I submit the married form with wages and working tax credit checked$/) do
  income_kind_page.submit_married_income_wages_tax_credit
end

Then(/^I should see an income list:$/) do |incomes|
  incomes.rows.each_with_index do |income, index|
    expect(income_kind_page.content.income_item[index].text).to eq income[0]
  end
end

Then(/^I should see an income list for myself and my partner$/) do
  expect(income_kind_page.content).to have_your_income
  expect(income_kind_page.content).to have_partners_income
  expect(income_kind_page.content.income_item.count).to eq 26
end

Then(/^I should see an income list for myself and my partner for ucd$/) do
  expect(income_kind_page.content).to have_your_income
  expect(income_kind_page.content).to have_partners_income
  expect(income_kind_page.content.income_item.count).to eq 34
end

When(/^I should see select your kinds of income error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(income_kind_page.content).to have_blank_error_link
end

Then(/^I should be taken to kind of income page$/) do
  expect(income_kind_page).to be_displayed
end

And(/^I slowly submit the form with wages checked$/) do
  income_kind_page.slowly_submit_single_income_wages_tax_credit
end

When('the ucd changes end') do
  Timecop.return
end
