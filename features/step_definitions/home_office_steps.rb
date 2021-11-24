Given("I am on the home office page") do
  to_home_office_page
  expect(home_office_page.content).to have_step_info
  expect(home_office_page.content).to have_header
  expect(home_office_page.content).to have_hint
end

When("I submit a valid home office number") do
  home_office_page.home_offce_number('1212-0001-0240-0490/01')
  continue
end

When("I submit an invalid home office number") do
  home_office_page.home_offce_number('L12345678/1')
  continue
  home_office_page.home_offce_number('L123456')
  continue
end

Then("I should see enter a valid home office number error message") do
  expect(home_office_page.content).to have_error_link
  expect(home_office_page.content).to have_error_message
end

Then("I should see what to do if I do not have either a national insurance number or home office number") do
  expect(home_office_page.content).to have_user_paper_form
end

Then("there should be a link paper application form") do
  expect(home_office_page.content.paper_form_link['href']).to end_with 'government/publications/apply-for-help-with-court-and-tribunal-fees'
end

Then("I should see further information about where to find my home office number") do
  expect(home_office_page.content).to have_help_text
end

Then("I should see enter your home office number error message") do
  expect(base_page.content).to have_there_is_a_problem
  expect(home_office_page.content).to have_blank_error_message
  expect(home_office_page.content.blank_error_link['href']).to end_with '#home_office_ho_number'
end
