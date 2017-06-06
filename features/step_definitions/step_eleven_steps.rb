Given(/^I visit the page for step eleven$/) do
  step 'I visit the page for step one'
  step 'I enter a valid form number'
  step 'I select no to have you already paid the fee?'
  step 'I select single'
  step 'I select £0 to £2,999'
  step 'I select no to do you receive any of the following benefits?'
  step 'I select no to do you have any children'
  step 'after selecting working tax credit from income list on step eight'
  step 'I click continue'
  step 'I select between'
  step 'I enter a valid total monthly income'
end

When(/^I click the continue button on step eleven$/) do
  step_eleven_page.continue_button.click
end

When(/^I select no to are you paying a fee for a probate case$/) do
  expect(step_eleven_page.block_label[0].text).to eq 'No'
  step_eleven_page.probate_case_false.click
  step_eleven_page.continue_button.click
end

When(/^I select yes to are you paying a fee for a probate case$/) do
  expect(step_eleven_page.block_label[1].text).to eq 'Yes'
  step_eleven_page.probate_case_true.click
  step_eleven_page.continue_button.click
end

When(/^I enter the name of deceased$/) do
  step_eleven_page.probate_deceased_name.set('John Smith')
end

When(/^I enter a valid date of death$/) do
  step_eleven_page.probate_date_of_death.set(Time.zone.today - 1.month)
  step_eleven_page.continue_button.click
end

When(/^I enter a date over twenty years ago$/) do
  step_eleven_page.probate_case_true.click
  step_eleven_page.probate_deceased_name.set('John Smith')
  step_eleven_page.probate_date_of_death.set(Time.zone.today - 21.years)
  step_eleven_page.continue_button.click
end


When(/^I enter a invalid date of death$/) do
  step_eleven_page.probate_case_true.click
  step_eleven_page.probate_deceased_name.set('John Smith')
  step_eleven_page.probate_date_of_death.set('hfdskghk')
  step_eleven_page.continue_button.click
end

When(/^I enter a future date of death$/) do
  step_eleven_page.probate_case_true.click
  step_eleven_page.probate_deceased_name.set('John Smith')
  step_eleven_page.probate_date_of_death.set(Time.zone.today + 1.month)
  step_eleven_page.continue_button.click
end