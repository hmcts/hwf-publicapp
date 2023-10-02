require "rails_helper"

RSpec.describe NotifyMailer do
  describe "#ask_for_help_email" do
    let(:form) { instance_double(Forms::HelpRequest, name: 'John Doe', email: 'johndoe@example.com', description: 'Test') }
    let(:mail) { described_class.ask_for_help_email(form) }

    it_behaves_like 'a Notify mail', template_id: ENV.fetch('NOTIFY_TECHNICAL_FORM', nil)

    it 'has the right values' do
      expect(mail.govuk_notify_personalisation).to eq({
                                                        form_name: 'John Doe',
                                                        reply_to: 'johndoe@example.com',
                                                        form_description: 'Test'
                                                      })
    end

  end
end
