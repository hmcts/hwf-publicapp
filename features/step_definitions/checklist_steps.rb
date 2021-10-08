Given(/^I am on the checklist page$/) do
  checklist_page.load_page
  expect(checklist_page).to be_displayed
  expect(checklist_page.content).to have_header
end

Then(/^I see that I need my national insurance number or home office number$/) do
  expect(checklist_page.content).to have_list_item_ni_number
  expect(checklist_page.content).to have_list_item_ho_number
end

Then(/^if I do not have a national insurance or home office number then I can use the paper form$/) do
  expect(checklist_page.content).to have_use_paper_form
  expect(checklist_page.content.use_paper_form_link['href']).to end_with 'government/publications/apply-for-help-with-court-and-tribunal-fees'
end

When(/^I click on if you do not know your national insurance number$/) do
  expect(checklist_page.content.do_not_know[0].text).to eq "If you don’t know your National Insurance number"
  checklist_page.click_do_not_know
end

Then(/^I should see where I can find my national insurance number$/) do
  expect(checklist_page.content).to have_look_for_ni
end

When(/^I click on if you do not know your home office number$/) do
  expect(checklist_page.content.do_not_know[1].text).to eq "If you don't know your Home Office reference number"
  checklist_page.click_do_not_know_2
end

Then(/^I should see where I can find my home office number$/) do
  expect(checklist_page.content).to have_look_for_ho
end

Then(/^a link to receive a reminder in the post$/) do
  expect(checklist_page.content.reminder['href']).to end_with 'lost-national-insurance-number'
end

Then(/^I see that I need to make sure that I have the court or tribunal form number$/) do
  expect(checklist_page.content).to have_list_item_form_number
end

Then(/^I see that I need to make sure that I have the case number, claim number or notice to pay$/) do
  expect(checklist_page.content).to have_list_item_case_number
end

When(/^I continue$/) do
  checklist_continue
end

Then(/^I should be taken to form number page$/) do
  expect(form_name_page).to be_displayed
end

Then(/^I should see a list of seven links$/) do
  expect(footer_page.content.footer_links.text).to have_content("Help")
  expect(footer_page.content.footer_links.text).to have_content("Cookies")
  expect(footer_page.content.footer_links.text).to have_content("Contact")
  expect(footer_page.content.footer_links.text).to have_content("Privacy policy")
  expect(footer_page.content.footer_links.text).to have_content("Terms and conditions")
  expect(footer_page.content.footer_links.text).to have_content("Cymraeg")
  expect(footer_page.content.footer_links.text).to have_content("Accessibility statement")
end
