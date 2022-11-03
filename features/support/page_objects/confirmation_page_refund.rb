class ConfirmationPageRefund < BasePage
  set_url '/confirmation/refund'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 22 of 22'
    element :header, 'h1', text: 'Send your reference number to complete the process'
    element :confirmation_header_paper_one, 'h2', text: 'Your application is not yet complete. You now need to take action.'
    element :confirmation_header_paper_two, 'h2', text: 'You must provide the court or tribunal with this reference number to proceed.'
    element :confirmation_instruction_line_one, 'p', text: 'Enter this reference number on the help with fees section of your court or tribunal application form'
    element :confirmation_instruction_line_two, 'p', text: 'If your form does not have a help with fees section, write the reference number at the top of the form.'
    section :list, '.steps-panel-confirmation' do
      element :one, 'p', text: 'Reference: '
      element :two, 'p', text: 'I have completed on online application for help with fees [insert application type and case number if you have one].'
      element :three, 'p', text: 'Yours sincerely,'
    end
    element :next_step, 'p', text: 'We will contact you within 21 days to tell you if you need to provide more information or you need to pay towards your court or tribunal fee.'
    element :feedback_text, 'p', text: 'After you finish your application, you are directed to an optional feedback form.'
    element :finish_application_button, 'input[value="Finish application"]'

    element :confirmation_header_online_one, 'h2', text: 'Your application is not yet complete. You now need to take action.'
    element :confirmation_header_online_two, 'h2', text: 'Enter this help with fees reference number in the help with fees section of the online form.'
    element :confirmation_instruction_online, 'p', text: 'Enter your reference above into the help with fees section of the online form. Your online court application form should look something like this:'
    element :next_step_online, 'p', text: 'We will contact you if you need to provide more information or you need to pay towards your court or tribunal fee.'
  end

  def submit
    Rails.application.config.finish_page_redirect_url = '/'
    content.finish_application_button.click
  end
end
