require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'set locale' do
      it 'to default if incorrect value' do
        get :index, params: { locale: 'test' }
        expect(I18n.locale).to be(:en)
      end

      it 'to approved value' do
        get :index, params: { locale: 'cy' }
        expect(I18n.locale).to be(:cy)
      end
    end
  end

  describe '#terms_and_conditions' do
    it 'returns http success' do
      get :terms_and_conditions
      expect(response).to have_http_status(:success)
    end
  end

  describe '#checklist' do
    it 'returns http success' do
      get :checklist
      expect(response).to have_http_status(:success)
    end
  end

  describe '#accessibility_statement' do
    it 'returns http success' do
      get :accessibility_statement
      expect(response).to have_http_status(:success)
    end
  end

  describe '#privacy_policy' do
    it 'returns http success' do
      get :privacy_policy
      expect(response).to have_http_status(:success)
    end
  end

  describe '#cookies' do
    it 'renders the expected page' do
      get :cookies
      expect(response).to render_template(:cookies)
    end

    it 'sets for cookie_setting form object' do
      get :cookies
      expect(assigns(:form)).to be_a(Forms::Cookie::SettingForm)
    end
  end

  describe '#update' do
    let(:referer) { 'http://local.net/page' }

    before do
      request.env['HTTP_REFERER'] = referer
    end

    Forms::Cookie::SettingForm.choices.each do |selection|
      it "saves cookie preferences #{selection}" do
        allow(Forms::Cookie::SettingForm).to receive(:new).
          and_return(Forms::Cookie::SettingForm.new)
        put :update, params: { cookie_setting: { cookie_setting: selection } }
        expect(Forms::Cookie::SettingForm).to have_received(:new).with(hash_including(cookie_setting: selection))
      end
    end

    it 'sets notification flag' do
      put :update, params: { cookie_setting: { cookie_setting: 'yes' } }
      expect(flash[:cookie_notification]).to be_present
    end

    it 'redirects to cookies page' do
      put :update, params: { cookie_setting: { cookie_setting: 'yes' } }
      expect(response).to redirect_to(referer)
    end
  end

end
