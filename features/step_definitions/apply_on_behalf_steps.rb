Given(/^I am on the apply on behalf page$/) do
  to_apply_on_behalf_page
  expect(applying_on_behalf_page.content).to have_step_info
  expect(applying_on_behalf_page.content).to have_header
  expect(applying_on_behalf_page.content).to have_hint_text
end

Then(/^I should be taken to apply on behalf page$/) do
  expect(applying_on_behalf_page).to be_displayed
end

When(/^I select yes to are you applying on behalf of someone$/) do
  applying_on_behalf_page.submit_yes
  expect(legal_representative_page).to be_displayed
end

When(/^I select no to are you applying on behalf of someone$/) do
  applying_on_behalf_page.submit_no
  expect(national_insurance_page).to be_displayed
end