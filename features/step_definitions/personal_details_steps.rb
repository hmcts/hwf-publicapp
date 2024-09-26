Given(/^I am on the personal details page with probate enabled$/) do
  probate_enabled
  to_personal_details_page_single
  expect(personal_details_page).to be_displayed
  expect(personal_details_page.content).to have_step_info
  expect(personal_details_page.content).to have_header
end

Given(/^I am married and on the personal details page with probate enabled$/) do
  probate_enabled
  to_personal_details_page_married
  expect(personal_details_page).to be_displayed
  expect(personal_details_page.content).to have_step_info
  expect(personal_details_page.content).to have_married_header
end

When(/^I enter my title$/) do
  expect(personal_details_page.content).to have_optional_hint
  personal_details_page.title('Ms')
end

When(/^I enter my first name$/) do
  personal_details_page.first_name('Sally')
end

When(/^I enter my last name$/) do
  personal_details_page.last_name('Smith')
  continue
end

When(/^I enter my full name$/) do
  personal_details_page.submit_full_name
end

Then(/^I should be taken to personal details page$/) do
  expect(personal_details_page).to be_displayed
end

When(/^I enter my first name with special characters$/) do
  personal_details_page.first_name('¡€#')
end

When(/^I enter my last name with special characters$/) do
  personal_details_page.last_name('!@£')
end

When(/^I slowly enter my name$/) do
  travel 61.minutes do
    personal_details_page.submit_full_name
  end
end

When(/^I enter mine and my partner's names$/) do
  personal_details_page.submit_full_names
  continue
end
