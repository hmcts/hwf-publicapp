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