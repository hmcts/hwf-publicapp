class ConfirmationPage < BasePage
  set_url '/confirmation'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 22 of 22'
    element :header, 'h1', text: 'Reference number to add to your claim form'
    element :confirmation_header, 'h2', text: 'Your application for help with fees is not finished yet'
    section :list, '.govuk-list' do
      element :one, 'li', text: 'You must write this reference number HWF-000-000 on your C100 form.'
      element :two, 'li', text: 'Write the reference number in the ‘HWF reference’ field if there is one. If not, you should write it wherever there is space on your C100 form.'
      element :three, 'li', text: 'You can also save or print this page and attach it to your C100 form.'
      element :four, 'li', text: 'If you provided your email address, you\'ll get your application reference number by email.'
    end
  end

end
