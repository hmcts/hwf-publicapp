When('the ucd changes apply') do
  time = Time.zone.local(2026, 11, 28, 10, 5, 0)
  Timecop.freeze(time)
end

Then('I should be on the application on behalf of someone else page') do
  expect(on_behalf_page.content).to have_header
end

When('I answer No to on behalf question') do
  on_behalf_page.not_applying_on_behalf
end

When('I answer Yes to on behalf question') do
  on_behalf_page.applying_on_behalf
end

Then('I should be on are you legal representative page') do
  expect(legal_representative_page.content).to have_header
end

When('I answer legal representative') do
  legal_representative_page.legal_representative
end

Then('I should be on legal representative detail page') do
  expect(legal_representative_detail_page.content).to have_header
end

When('I fill in all mandatory fields for legal representative') do
  legal_representative_detail_page.fill_in_mandatory_fields
end

Then('I should be on are you applying for over 16 page') do
  expect(over_16_page.content).to have_header
end

When('I answer yes to over 16') do
  over_16_page.applicant_over_16
end

When('I answer no to over 16') do
  over_16_page.applicant_under_16
end

Then(/^I should be taken to partner national insurance page$/) do
  expect(partner_national_insurance_page.content).to have_header
end

When(/^I select my partner does not have a national insurance number$/) do
  partner_national_insurance_page.submit_no_ni
end