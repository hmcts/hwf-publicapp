def form_group_4(index)
  step_four_page.content.form_group[index]
end

Given(/^I am a single person on the step four page$/) do
  step 'I visit the page for step one'
  step 'I enter a valid form number'
  step 'I select no to have you already paid the fee?'
  step 'I select single'
end

Given(/^I am a married person on the step four page$/) do
  step 'I visit the page for step one'
  step 'I enter a valid form number'
  step 'I select no to have you already paid the fee?'
  step 'I select married'
end

When(/^I select £0 to £2,999$/) do
  expect(form_group_4(0).block_label[0].text).to eq '£0 to £2,999'
  expect(form_group_4(0).savings_and_investment_choice_less['type']).to eq 'radio'
  form_group_4(0).savings_and_investment_choice_less.click
  form_group_4(2).continue_button.click
end

When(/^I select £3,000 to £15,999$/) do
  expect(form_group_4(0).block_label[1].text).to eq '£3,000 to £15,999'
  expect(form_group_4(0).savings_and_investment_choice_between['type']).to eq 'radio'
  form_group_4(0).savings_and_investment_choice_between.click
  form_group_4(2).continue_button.click
end

When(/^I select £16,000 or more$/) do
  expect(form_group_4(0).block_label[2].text).to eq '£16,000 or more'
  expect(form_group_4(0).savings_and_investment_choice_more['type']).to eq 'radio'
  form_group_4(0).savings_and_investment_choice_more.click
  form_group_4(2).continue_button.click
end

Then(/^I should see step four label$/) do
  expect(form_group_4(0).label.text).to eq 'Form name or number'
end

Then(/^I should see help with savings and investments copy$/) do
  first_heading = form_group_4(1).details_content.heading_small[0].text
  second_heading = form_group_4(1).details_content.heading_small[1].text

  expect(first_heading).to have_content 'What to include in savings and investments:'
  expect(second_heading).to have_content 'Don’t include the following in your savings total:'
  expect(form_group_4(1).details_content.ul[0].li.count).to eq 8
  expect(form_group_4(1).details_content.ul[1].li.count).to eq 9
end

Then(/^I should not see the reminder to include my partners savings$/) do
  expect(step_four_page.content).to have_no_married_reminder
end

Then(/^I should see the reminder to include my partners savings$/) do
  married_reminder = step_four_page.content.married_reminder.text
  expect(married_reminder).to have_content 'include your partner’s savings and investments'
end
