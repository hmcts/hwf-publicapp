require 'rails_helper'

RSpec.describe ZendeskSender do
  subject(:service) { described_class.new }

  describe '#send_help_request' do
    subject(:send_help_request) { service.send_help_request(help_request) }

    let(:config) { double(:url= => nil, :username= => nil, :token= => nil) }
    let(:client) { double }
    let(:help_request) { double(name: 'NAME', email: 'EMAIL', description: 'DESCRIPTION') }

    before do
      Settings.zendesk.enabled = true
      allow(ZendeskAPI::Client).to receive(:new).and_yield(config).and_return(client)
      allow(ZendeskAPI::Ticket).to receive(:create!).with(client, attributes)
      send_help_request
    end

    after do
      Settings.zendesk.enabled = false
    end

    describe 'the ZendeskAPI client is initialised with' do
      let(:attributes) { Hash }

      it 'the correct url' do
        expect(config).to have_received(:url=).with('zendesk_url')
      end

      it 'the correct username' do
        expect(config).to have_received(:username=).with('zendesk_username')
      end

      it 'the correct token' do
        expect(config).to have_received(:token=).with('zendesk_token')
      end
    end

    describe 'the Zendesk ticket content' do
      let(:attributes) do
        {
          subject: 'NAME has requested assistance, please email them back on: EMAIL',
          description: 'DESCRIPTION',
          requester: {
            name: 'NAME',
            email: 'EMAIL'
          },
          custom_fields: [
            { id: '32342378', value: 'test' },
            { id: '24041286', value: 'EMAIL' },
            { id: '23757677', value: 'help_with_fees_technical_support' }
          ]
        }
      end

      it 'is composed correctly' do
        expect(ZendeskAPI::Ticket).to have_received(:create!).with(client, attributes)
      end
    end
  end
end
