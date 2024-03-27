And('I should be taken to income period page') do
  expect(income_period_page).to be_displayed
end

When(/^I submit the form with income '([^"]*)' and monthly$/) do |num|
  income_period_page.submit_income(num)
end
