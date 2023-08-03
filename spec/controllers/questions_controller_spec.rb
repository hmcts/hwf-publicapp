require 'rails_helper'

RSpec.describe QuestionsController do
  let(:online_application) { instance_double(OnlineApplication, :attributes= => nil) }
  let(:session) { double }
  let(:storage_started) { true }
  let(:storage) { instance_double(Storage, load_form: nil, save_form: nil, started?: storage_started, load_step_back: step_back, store_page_path: true) }
  let(:valid_id) { :question }
  let(:invalid_id) { :invalid }
  let(:form) { double }
  let(:question_title_view) { double }
  let(:step_back) { 'path' }

  before do
    allow(QuestionFormFactory).to receive(:get_form).with(valid_id).and_return(form)
    allow(QuestionFormFactory).to receive(:get_form).with(invalid_id).and_raise(QuestionFormFactory::QuestionDoesNotExist)
    allow(controller).to receive_messages(session: session, online_application: online_application)
    allow(Storage).to receive(:new).with(session).and_return(storage)
    allow(Views::QuestionTitle).to receive(:new).with(form, online_application).and_return(question_title_view)
  end

  describe 'GET #edit' do

    before do
      get :edit, params: { id: id }
    end

    context 'when the question is a valid one' do
      let(:id) { valid_id }

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end

      it 'assigns the form' do
        expect(assigns(:form)).to eql(form)
      end

      it 'assigns the back link' do
        expect(assigns(:previous_step)).to eql('path')
      end

      context 'no link back' do
        let(:step_back) { nil }

        it 'assigns checklist url' do
          expect(assigns(:previous_step)).to eql(checklist_url)
        end
      end

      it 'assigns the question title view' do
        expect(assigns(:title_view)).to eql(question_title_view)
      end

      it 'assigns the page number' do
        expect(assigns(:page_number)).to be 0
      end

      it 'loads the form from the storage' do
        expect(storage).to have_received(:load_form).with(form)
      end

      include_examples 'cache suppress headers'

      context 'when the storage is not started' do
        let(:storage_started) { false }

        it 'redirects to the home page' do
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when the question is invalid' do
      let(:id) { invalid_id }

      it 'responds with 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT #update' do
    let(:valid?) { false }
    let(:params) { { question_1: 'AAA', question_2: 'BBB' } }
    let(:form) { instance_double(Forms::Benefit, id: id, permitted_attributes: params.keys, update_attributes: nil, valid?: valid?, export: exported_form) }
    let(:exported_form) { double }

    let(:next_path) { root_path }
    let(:navigation) { instance_double(Navigation, next: next_path, page_number: 0) }
    let(:clear_service) { instance_double(ClearDownstreamQuestions, for_changes: nil) }
    let(:dupped_online_application) { double }

    before do
      allow(Navigation).to receive(:new).with(online_application, id).and_return(navigation)
      allow(ClearDownstreamQuestions).to receive(:new).with(storage, id).and_return(clear_service)
      allow(online_application).to receive(:dup).and_return(dupped_online_application)

      put :update, params: { id: id, id => params }
    end

    context 'when the question is a valid one' do
      let(:id) { valid_id }

      it 'updates the form with the posted params' do
        expect(form).to have_received(:update_attributes).with(params)
      end

      context 'when the form is valid' do
        let(:valid?) { true }

        it 'stores the form in the storage' do
          expect(storage).to have_received(:save_form).with(form)
        end

        it 'updates the online_application in progress' do
          expect(online_application).to have_received(:attributes=).with(exported_form)
        end

        it 'redirects to the next question based on the Navigation object' do
          expect(response).to redirect_to(next_path)
        end

        it 'calls the clearing service with old and updated online application' do
          expect(clear_service).to have_received(:for_changes).with(dupped_online_application, online_application)
        end
      end

      context 'when the form is invalid' do
        it 'renders the edit template' do
          expect(response).to render_template(:edit)
        end

        it 'assigns the form' do
          expect(assigns(:form)).to eql(form)
        end

        it 'assigns the page number' do
          expect(assigns(:page_number)).to be 0
        end

        it 'assigns the question title view' do
          expect(assigns(:title_view)).to eql(question_title_view)
        end
      end
    end

    context 'when the question is invalid' do
      let(:id) { invalid_id }

      it 'responds with 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
