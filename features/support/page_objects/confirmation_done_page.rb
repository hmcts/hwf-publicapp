class ConfirmationDonePage < BasePage
  set_url '/confirmation/done'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 23 of 23'
    element :header, 'h1', text: 'Send your claim form'
    element :send_your_form, 'h2', text: 'Send your C100 form with your HWF-'
    element :post, '.post', text: 'Deliver your paperwork to the court or tribunal dealing with your case. You can do this by post or in person.'
    element :courtfinder, 'p', text: 'Find the court or tribunal information here: https://www.gov.uk/find-court-tribunal (opens in new tab).'
    section :what_happens_next, '.steps-panel' do
      element :one, 'li', text: 'Your application will be assessed by court or tribunal staff. This usually takes no longer than 21 days.'
      element :two, 'li', text: 'You\'ll hear from the court or tribunal if your application is unsuccessful or if they need more information from you.'
      element :three, 'li', text: 'If your application is successful you\'ll hear directly from the court or tribunal dealing with your case.'
    end
    element :feedback_text, 'p', text: 'After you finish your application, you are directed to an optional feedback form.'
    element :finish_application_button, 'input[value="Finish application"]'
  end

  def submit
    Rails.application.config.finish_page_redirect_url = '/'
    content.finish_application_button.click
  end

end
