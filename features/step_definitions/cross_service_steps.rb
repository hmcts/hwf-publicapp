When("I copy the reference number") do
  @ref_number = find('.hwf-ref').text()
end

When('I launch staff app') do
  visit 'https://staff.demo.hwf.dsd.io/users/sign_in'
end

When('I process the application') do
  fill_in('Email', :with => "")
  fill_in('Password', :with => "")
  find('.govuk-button').click
  fill_in('Reference', :with => @ref_number)
  click_button('Look up')
end


