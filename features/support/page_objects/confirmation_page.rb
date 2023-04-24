class ConfirmationPage < BasePage
  set_url '/confirmation'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 22 of 22'
    element :header, 'h1', text: 'Send your claim form'
    element :header_refund, 'h1', text: 'Send your reference number to complete the process'
    element :confirmation_header_paper_one, 'h2', text: 'Your application is not yet complete. You now need to take action.'
    element :confirmation_header_paper_two, 'h2', text: 'You must provide the court or tribunal with this reference number to proceed.'
    element :confirmation_instruction_line_one, 'p', text: 'You have completed an application online for help paying a court or tribunal fee and you have been provided with the above reference number for your application.'
    element :confirmation_instruction_line_two, 'p', text: 'You now need to provide this reference number to the office, court or tribunal that will deal with the claim for which you want help with its fee.'
    element :next_step, 'p', text: 'They will contact you within 21 days to tell you if you need to provide more information or you need to pay towards your court or tribunal fee.'
    element :feedback_text, 'p', text: 'After you finish your application, you are directed to an optional feedback form.'
    element :finish_application_button, 'input[value="Finish application"]'

    element :confirmation_header_online_one, 'h2', text: 'Your application is not yet complete. You now need to take action.'
    element :confirmation_header_online_two, 'h2', text: 'Enter this help with fees reference number in the help with fees section of the online form.'
    element :confirmation_instruction_online, 'p', text: 'You have completed an application online for help paying a court or tribunal fee and you have been provided with the above reference number for your application.'
    element :next_step_online, 'p', text: 'They will contact you within 21 days to tell you if you need to provide more information or you need to pay towards your court or tribunal fee.'
  end

  def submit
    Rails.application.config.finish_page_redirect_url = '/'
    content.finish_application_button.click
  end
end
