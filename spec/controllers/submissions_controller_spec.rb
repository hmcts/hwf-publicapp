require 'rails_helper'

RSpec.describe SubmissionsController do
  let(:session) { double }
  let(:storage) { double }
  let(:online_application) { build(:online_application) }
  let(:builder) { instance_double(OnlineApplicationBuilder, online_application: online_application) }

  before do
    allow(controller).to receive(:session).and_return(session)
    allow(Storage).to receive(:new).with(session).and_return(storage)
    allow(OnlineApplicationBuilder).to receive(:new).with(storage).and_return(builder)
  end

  describe 'POST #create' do
    let(:service) { double }

    before do
      allow(SubmitApplication).to receive(:new).and_return(service)
      allow(service).to receive(:post).with(online_application).and_return(response)
      allow(storage).to receive(:submission_result=)

      post :create, params: { locale: 'cy' }
    end

    context 'submit with correct params' do
      it {
        expect(SubmitApplication).to have_received(:new).with(Settings.submission.url, Settings.submission.token, 'cy')
      }
    end

    context 'on a successful response' do
      let(:response) { { result: true, message: 'HWF-000-000' } }

      it 'stores the result on the session' do
        expect(storage).to have_received(:submission_result=).with(response)
      end

      context 'when it is a refund application' do
        let(:online_application) { build(:online_application, :refund) }

        it 'redirects to the default confirmation page' do
          expect(response).to redirect_to(refund_confirmation_path)
        end
      end

      context 'when the application is not a refund' do
        it 'redirects to the default confirmation page' do
          expect(response).to redirect_to(confirmation_path)
        end
      end

    end

    context 'on a failed response' do
      let(:response) { { result: false, message: 'Failed' } }

      it 'stores the result on the session' do
        expect(storage).to have_received(:submission_result=).with(response)
      end

      it 'redirects to the summary page' do
        expect(response).to redirect_to(summary_path)
      end

      it 'sets an flash error message' do
        expect(flash[:error]).to eql('We couldn\'t process your application at this time. Please try again later.')
      end
    end
  end
end
