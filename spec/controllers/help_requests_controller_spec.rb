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

    let(:zendesk_sender) { instance_double(ZendeskSender, send_help_request: nil) }

    before do
      post :create, params: { id => params }
    end

    context 'for valid parameters' do
      let(:params) { { name: 'N', email: 'E', description: 'D' } }
      let(:valid?) { true }

      it 'updates the form from the parameters' do
        expect(form).to have_received(:update_attributes).with(params)
      end

      it 'sends an email' do
        expect { post :create, params: { id => params } }.to change { ActionMailer::Base.deliveries.count }.by(1)
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
