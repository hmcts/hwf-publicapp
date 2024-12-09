Given(/^I am '([^"]*)' and on the address page with probate enabled$/) do |status|
  probate_enabled
  status == 'married' ? to_address_page('married') : to_address_page('single')
  expect(address_page.content).to have_step_info
  expect(address_page.content).to have_header
end

When(/^I enter my address with postcode$/) do
  address_page.submit_full_address
end

When(/^I enter my address$/) do
  address_page.street('102 Petty France')
  address_page.town('London')
end

When(/^I enter my postcode$/) do
  address_page.post_code('SW1H 9AJ')
end

Then(/^I should be taken to address page$/) do
  expect(address_page).to be_displayed
end

When(/^I enter my postcode with special characters$/) do
  address_page.post_code('¡€#¢∞§')
end

When(/^I enter my address with postcode after a long time$/) do
  address_page.slow_submit_full_address
end
