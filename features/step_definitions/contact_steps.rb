Given(/^I am on the contact page with probate enabled$/) do
  probate_enabled
  to_contact_page
  expect(contact_page.content).to have_step_info
  expect(contact_page.content).to have_header
  expect(contact_page.content).to have_confirmation_email
end

When(/^I enter a valid email address$/) do
  expect(contact_page.content).to have_email_label
  expect(contact_page.content).to have_optional_hint
  contact_page.valid_email
end

When(/^I enter an invalid email address$/) do
  contact_page.invalid_email
end

And(/^I click share experience checkbox$/) do
  contact_page.click_share_experience
end

Then(/^I remain on this page$/) do
  expect(contact_page).to be_displayed
end

Then(/^I should be taken to apply type page$/) do
  expect(apply_type_page).to be_displayed
end

Then(/^I should be taken to contact page$/) do
  expect(contact_page).to be_displayed
end

When(/^I enter a valid email address after a long time$/) do
  contact_page.slow_submit_email
end
