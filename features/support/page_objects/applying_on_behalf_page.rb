class ApplyingOnBehalfPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/applying_on_behalf'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 3 of 25'
    element :header, 'h1', text: 'Is the application on behalf of someone else?'
    element :hint_text, '.govuk-hint', text: 'Is the application on behalf of someone else?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    section :alert, 'div[role="alert"]' do
      element :blank_error_link, 'a.error-link'
    end
  end

  def submit_yes
    applying_on_behalf_page.content.yes.click
    continue
  end

  def submit_no
    applying_on_behalf_page.content.no.click
    continue
  end

end
