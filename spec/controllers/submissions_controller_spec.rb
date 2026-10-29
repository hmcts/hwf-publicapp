require 'rails_helper'

RSpec.describe SubmissionsController do
  let(:session) { double }
  let(:app_id) { SecureRandom.uuid }
  let(:storage) { double(started?: storage_started, form_saved?: true) }
  let(:storage_started) { true }
  let(:online_application) { build(:online_application, calculation_scheme: schema) }
  let(:builder) { instance_double(OnlineApplicationBuilder, online_application: online_application) }
  let(:schema) { 'scheme' }

  before do
    allow(controller).to receive(:session).and_return(session)
    allow(Storage).to receive(:new).with(session, app_id).and_return(storage)
    allow(OnlineApplicationBuilder).to receive(:new).with(storage).and_return(builder)
  end

  describe 'POST #create' do
    let(:service) { double }
    let(:statement) { instance_double(Forms::Statement, valid?: true, signed_by: 'applicant', id: 'statement', update_attributes: true) }

    before do
      allow(Forms::Statement).to receive(:new).and_return statement
      allow(SubmitApplication).to receive(:new).and_return(service)
      allow(service).to receive(:post).with(online_application).and_return(response)
      allow(storage).to receive(:submission_result=)
      allow(storage).to receive(:save_form)

      post :create, params: { locale: 'cy', app_id: app_id }
    end

    context 'when answers the summary flags as missing are not given' do
      let(:online_application) { build(:online_application, married: true, partner_date_of_birth: nil) }
      let(:response) { { result: true } }

      it 'does not submit the application' do
        expect(SubmitApplication).not_to have_received(:new)
      end

      it 'redirects to the summary page' do
        expect(response).to redirect_to(summary_path)
      end

      it 'sets an flash error message' do
        expect(flash[:error]).to eql(I18n.t('.summary.invalid_footer'))
      end
    end

    context 'when the storage is not started' do
      let(:storage_started) { false }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'submit with correct params' do
      it {
        expect(SubmitApplication).to have_received(:new).with(Settings.submission.url, Settings.submission.token, 'cy')
      }
    end

    context 'on a successful response' do
      let(:response) { { result: true, message: 'HWF-000-000' } }

      context 'signed by' do
        let(:schema) { Rails.configuration.ucd_schema }

        it 'assigns statement to online application' do
          expect(online_application.statement_signed_by).to eq 'applicant'
        end

        it 'save statement form' do
          expect(storage).to have_received(:save_form).with(statement)
        end

      end

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
        expect(flash[:error]).to eql(I18n.t('.confirmation.submission_error'))
      end
    end
  end
end
