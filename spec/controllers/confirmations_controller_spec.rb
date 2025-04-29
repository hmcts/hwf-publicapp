require 'rails_helper'

RSpec.describe ConfirmationsController do
  let(:session) { double }
  let(:online_application) { instance_double(OnlineApplication, benefits: true) }
  let(:result) { { result: true, message: 'HWF-010101' } }
  let(:storage_started) { true }
  let(:storage) { instance_double(Storage, submission_result: result, started?: storage_started, clear: true) }
  let(:builder) { instance_double(OnlineApplicationBuilder, online_application: online_application) }

  before do
    allow(controller).to receive(:session).and_return(session)
    allow(session).to receive(:clear)
    allow(Storage).to receive(:new).with(session).and_return(storage)
    allow(OnlineApplicationBuilder).to receive(:new).with(storage).and_return(builder)
  end

  describe 'POST #create' do
    let(:params) { { forms_reference_confirm: { reference_confirm: 'true' } } }

    context 'when the form is valid' do
      let(:form_instance) { instance_double(Forms::ReferenceConfirm, valid?: true) }

      before do
        allow(Forms::ReferenceConfirm).to receive(:new).and_return(form_instance)
        post :create, params: params
      end

      it 'clears the cache' do
        expect(storage).to have_received(:clear)
      end

      it 'redirects to the finish session path' do
        expect(response).to redirect_to(finish_session_path)
      end
    end

    context 'when the form is invalid' do
      let(:error_message) { 'Some error message' }
      let(:form_errors) { instance_double(ActiveModel::Errors, clear: true, add: nil) }
      let(:form_instance) { instance_double(Forms::ReferenceConfirm, valid?: false, errors: form_errors) }

      before do
        allow(Forms::ReferenceConfirm).to receive(:new).and_return(form_instance)
        allow(I18n).to receive(:t).and_return(error_message)
      end

      context 'and applying_method is nil and refund is true' do
        let(:online_application) { instance_double(OnlineApplication, applying_method: nil, refund: true) }

        before { post :create, params: params }

        it 'renders the refund template' do
          expect(response).to render_template(:refund)
        end

        it 'sets the flash error message' do
          expect(flash.now[:error]).to eql(error_message)
        end
      end

      context 'and applying_method is present' do
        let(:online_application) { instance_double(OnlineApplication, applying_method: 'online', refund: false) }

        before { post :create, params: params }

        it 'renders the show template' do
          expect(response).to render_template(:show)
        end

        it 'sets the flash error message' do
          expect(flash.now[:error]).to eql(error_message)
        end
      end
    end

    context 'when parameters are missing' do
      before do
        allow(online_application).to receive_messages(applying_method: nil, refund: false)
      end

      it 'does not raise an error' do
        post :create
        expect(response).to render_template(:show)
      end
    end

  end

  describe 'GET #show' do
    before { get :show }

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns the online application model' do
      expect(assigns(:online_application)).to eql(online_application)
    end

    it 'assigns the submission result' do
      expect(assigns(:result)).to eql(result)
    end

    it 'assigns a new form object' do
      expect(assigns(:form)).to be_an_instance_of(Forms::ReferenceConfirm)
    end

    it_behaves_like 'cache suppress headers'

    context 'when storage has been cleared' do
      let(:storage_started) { false }
      let(:result) { nil }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #refund' do
    before { get :refund }

    it 'renders the refund template' do
      expect(response).to render_template(:refund)
    end

    it 'assigns the online application model' do
      expect(assigns(:online_application)).to eql(online_application)
    end

    it 'assigns the submission result' do
      expect(assigns(:result)).to eql(result)
    end

    it 'assigns a new form object' do
      expect(assigns(:form)).to be_an_instance_of(Forms::ReferenceConfirm)
    end

    it_behaves_like 'cache suppress headers'

    context 'when storage has been cleared' do
      let(:storage_started) { false }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
