require 'rails_helper'

RSpec.describe SessionsController do
  let(:session) { double }
  let(:storage) { instance_double(Storage, start: nil, clear: nil) }
  let(:app_id) { SecureRandom.uuid }

  before do
    allow(controller).to receive(:session).and_return(session)
  end

  describe 'GET #start' do
    before do
      allow(Storage).to receive(:new).with(session, kind_of(String)).and_return(storage)

      get :start
    end

    it 'starts the storage' do
      expect(storage).to have_received(:start)
    end

    it 'redirects to the fee question of a newly generated application' do
      expect(response.location).to match(%r{/applications/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/questions/fee})
    end
  end

  describe 'POST #finish' do
    let(:external_url) { nil }

    before do
      allow(Rails.application.config).to receive(:finish_page_redirect_url).and_return(external_url)
      allow(Storage).to receive(:new).with(session, app_id, clear: true).and_return(storage)

      post :finish, params: { app_id: app_id }
    end

    context 'when the done page external url is set' do
      let(:external_url) { 'http://som.e.t.h.i.ng' }

      it 'redirects to the external page' do
        expect(response).to redirect_to(external_url)
      end
    end

    context 'when no done page external url is set' do
      it 'redirects to the homepage' do
        expect(response).to redirect_to(root_path)
      end
    end

  end

  describe 'DELETE #destroy' do
    before do
      allow(Storage).to receive(:new).with(session, app_id, clear: true).and_return(storage)

      delete :destroy, params: { app_id: app_id }
    end

    it 'redirects to the start page' do
      expect(response).to redirect_to(root_path)
    end
  end
end
