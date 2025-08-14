class ConfirmationPage < BasePage
  include ActiveSupport::Testing::TimeHelpers

  set_url '/confirmation'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 25 of 25'
    element :header, 'h1', text: 'Send your claim form'
    element :header_refund, 'h1', text: 'Send your reference number to complete the process'
    element :confirmation_header_paper_one, 'h2', text: 'Your Help with Fees reference number is'
    element :confirmation_header_paper_two, 'h2', text: 'You have one more step to take below'
    element :confirmation_instruction_line_one, 'p', text: 'You have completed an application online for help paying a court or tribunal fee and you have been provided with the above reference number for your application.'
    element :confirmation_instruction_line_two, 'p', text: 'You now need to provide this reference number to the office, court or tribunal that will deal with the claim for which you want help with its fee alongside evidence of any qualifying benefits (if applicable).'
    element :next_step, 'p', text: 'Once the court or tribunal have received your reference number they will process your help with fees application. They will then contact you to tell you if you need to provide more information or you need to pay towards your court or tribunal fee.'
    element :feedback_text, 'p', text: 'After you finish your application, you are directed to an optional feedback form.'
    element :finish_application_button, 'input[value="Finish application"]'
    element :confirmation_checkbox, 'input#forms_reference_confirm_reference_confirm', visible: :all
    element :confirmation_error, 'p.govuk-error-message', text: 'You must confirm you will send the above reference number to court/tribunal for processing'

    element :confirmation_header_online_one, 'h2', text: 'Your Help with Fees reference number is'
    element :confirmation_header_online_two, 'h2', text: 'You have one more step to take below'
    element :confirmation_instruction_online, 'p', text: 'You have completed an application online for help paying a court or tribunal fee.'
    element :next_step_online, 'p', text: 'Once the court or tribunal have received your reference number they will process your help with fees application. They will then contact you to tell you if you need to provide more information or you need to pay towards your court or tribunal fee.'
    element :confirmation_error_online, 'p.govuk-error-message', text: 'You must confirm you will add the above reference number to your online court/tribunal application'
  end

  def submit
    Rails.application.config.finish_page_redirect_url = '/'
    content.finish_application_button.click
  end

  def slowly_submit
    travel 61.minutes do
      Rails.application.config.finish_page_redirect_url = '/'
      content.finish_application_button.click
    end
  end

  def check_confirmation_checkbox
    content.confirmation_checkbox.set(true)
  end
end
