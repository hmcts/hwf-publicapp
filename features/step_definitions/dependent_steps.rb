Given(/^I am ([^"]*)' and on the dependent page$/) do |status|
  status == 'married' ? to_dependent_page('married') : to_dependent_page('single')
  expect(dependent_page.content).to have_step_info
  expect(dependent_page.content).to have_header
end

When(/^I submit the form with no I do not have any children$/) do
  dependent_page.content.children_number.select 0
  continue
end

When(/^I submit the form with four children$/) do
  expect(dependent_page.content).to have_children_number
  dependent_page.content.children_number.select 4
  continue
end

When(/^I add I have three children$/) do
  dependent_page.content.children_number.select 3
  continue
end

Then(/^I should see help with financially dependent children copy$/) do
  expect(dependent_page.content).to have_give_details
  expect(dependent_page.content).to have_includes_children
  expect(dependent_page.content).to have_children_under
  expect(dependent_page.content).to have_children_between
  expect(dependent_page.content).to have_regular_maintenance
  expect(dependent_page.content).to have_child_tax_link
end

Then(/^I should be taken to dependent page$/) do
  expect(dependent_page).to be_displayed
end

When(/^I submit the form with no I do not have any children after a long time$/) do
  dependent_page.slow_submit_dependent_no
end

When(/^I submit the form with yes I do have children after a long time$/) do
  dependent_page.slow_submit_dependent_yes
end
