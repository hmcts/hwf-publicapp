Given(/^I am on the personal details page with probate enabled$/) do
  probate_enabled
  to_personal_details_page
  expect(personal_details_page).to be_displayed
  expect(personal_details_page.content).to have_step_info
  expect(personal_details_page.content).to have_header
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