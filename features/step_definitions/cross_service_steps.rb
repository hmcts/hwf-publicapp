When("I copy the reference number") do
  @ref_number = find('.hwf-ref').text()
end

When('I launch staff app') do
  visit 'https://staff.demo.hwf.dsd.io/users/sign_in'
end

When('I process the application') do
  fill_in('Email', :with => ENV['DEMO_EMAIL'])
  fill_in('Password', :with => ENV['DEMO_PASSWORD'])
  find('.govuk-button').click
  fill_in('Reference', :with => @ref_number)
  click_button('Look up')
  fill_in('How much is the court or tribunal fee?', :with => "200")
  choose('County' , visible: false, allow_label_click: true)
  fill_in('Day', :with => Time.zone.now.day)
  fill_in('Month', :with => Time.zone.now.month)
  fill_in('Year', :with => Time.zone.now.year)
  click_button('Next')
  click_button('Complete processing')
  expect(page).to have_content 'Application complete'
end

