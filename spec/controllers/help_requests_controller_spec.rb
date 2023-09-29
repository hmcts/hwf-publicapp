require 'rails_helper'

RSpec.describe HelpRequestsController do
  before do
    allow(Forms::HelpRequest).to receive(:new).and_return(form)
  end

  describe 'GET #new' do
    let(:form) { double }

    before do
      get :new
    end

    it 'renders the correct template' do
      expect(response).to render_template(:new)
    end

    it 'assigns the form' do
      expect(assigns(:form)).to eql(form)
    end
  end

  describe 'POST #create' do
    let(:params) { { name: 'N', email: 'E', description: 'D' } }
    let(:id) { :help_request }
    let(:form) do
      instance_double(Forms::HelpRequest,
                      id: id, permitted_attributes: params.keys, update_attributes: nil, valid?: valid?,
                      name: 'John Doe', email: 'johndoe@example.com', description: 'Test')
    end
    let(:ask_for_help_email) { instance_double(ActionMailer::MessageDelivery, deliver_now: true) }

    before do
      allow(NotifyMailer).to receive_messages(ask_for_help_email: ask_for_help_email)
      post :create, params: { id => params }
    end

    context 'for valid parameters' do
      let(:params) { { name: 'N', email: 'E', description: 'D' } }
      let(:valid?) { true }

      it 'updates the form from the parameters' do
        expect(form).to have_received(:update_attributes).with(params)
      end

      it 'sends an email' do
        expect(NotifyMailer).to have_received(:ask_for_help_email).with(form)
        expect(ask_for_help_email).to have_received(:deliver_now)
      end

      it 'sets a flash message' do
        expect(flash[:info]).not_to be_empty
      end

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'for invalid parameters' do
      let(:valid?) { false }

      it 'updates the form from the parameters' do
        expect(form).to have_received(:update_attributes).with(params)
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end

      it 'assigns the form' do
        expect(assigns(:form)).to eql(form)
      end
    end
  end
end
