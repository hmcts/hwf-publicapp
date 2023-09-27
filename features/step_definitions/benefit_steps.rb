Given(/^I am on the benefit page$/) do
  to_benefit_page
  expect(benefit_page).to be_displayed
  expect(benefit_page.content).to have_step_info
  expect(benefit_page.content).to have_header
end

When(/^I submit the form with yes I am receiving one of the benefits listed$/) do
  benefit_page.submit_benefit_yes
end

When(/^I submit the form with no I do not receive one of the benefits listed$/) do
  benefit_page.submit_benefit_no
end

Then(/^I should see the instruction bullet points:$/) do |benefits|
  expect(benefit_page.content).to have_benefits_text
  benefits.rows.each_with_index do |benefit, index|
    expect(benefit_page.content.li[index].text).to eq benefit[0]
  end
end

Then(/^I should see the benefits table:$/) do |table|
  table.raw.each_with_index do |item, index|
    first = index * 2
    expect(benefit_page.content.td[first].text).to have_text item[0]
    expect(benefit_page.content.td[first + 1].text).to have_text item[1]
  end
end

Then(/^I should see help with benefits copy$/) do
  expect(benefit_page.content).to have_help_with_benefits
  expect(benefit_page.content).to have_recently_receiving_heading
  expect(benefit_page.content).to have_provide_a_letter
  expect(benefit_page.content).to have_similar_names_heading
  expect(benefit_page.content).to have_benefits_with_similar_names
  expect(benefit_page.content).to have_job_seekers
  expect(benefit_page.content).to have_employment_support
  expect(benefit_page.content).to have_pension_credit
  expect(benefit_page.content).to have_universal_credit
  expect(benefit_page.content).to have_laa_assistance
  expect(benefit_page.content).to have_laa_representation
end

Then(/^I should see select whether you're receiving one of the benefits listed error message$/) do
  expect(base_page.content.alert).to have_there_is_a_problem
  expect(benefit_page.content).to have_blank_error_link
end

Then(/^I should be taken to the probate page$/) do
  expect(probate_page).to be_displayed
  expect(probate_page.content).to have_header
end

Then(/^I should be taken to the claim page$/) do
  expect(claim_page).to be_displayed
  expect(claim_page.content).to have_header
end

When(/^I slowly submit the form with yes I am receiving one of the benefits listed$/) do
  benefit_page.slowly_submit_benefit_yes
end

When(/^I slowly submit the form with no I am not receiving one of the benefits listed$/) do
  benefit_page.slowly_submit_benefit_no
end