class ContactPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/contact'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 22 of 25'
    element :header, 'h1', text: 'What\'s your email address?'
    element :email_label, '.govuk-label', text: 'Email address'
    element :optional_hint, '.optional', text: '(Optional)'
    element :contact_email, '#contact_email'
    element :confirmation_email, 'p', text: 'If you provide your email address, you will receive confirmation of your Help with Fees reference number and a copy of your online Help with Fees application'
    element :share_experience, '.govuk-checkboxes', text: 'Check this box if you\'re willing to share your experience of this service.'
  end

  def valid_email
    content.contact_email.set 'test@hmcts.net'
    continue
  end

  def invalid_email
    content.contact_email.set 'testhmctsnet'
    continue
  end

  def click_share_experience
    content.share_experience.click
  end

  def slow_submit_email
    travel 61.minutes do
      contact_page.valid_email
    end
  end
end
