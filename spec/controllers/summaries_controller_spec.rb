require 'rails_helper'

RSpec.describe SummariesController do

  describe 'GET #show' do
    let(:app_id) { SecureRandom.uuid }
    let(:storage_started) { true }
    let(:storage) { instance_double(Storage, started?: storage_started, form_saved?: true) }
    let(:online_application) { build(:online_application) }
    let(:summary_view) { instance_double(Views::Summary, incomplete?: incomplete) }
    let(:incomplete) { false }

    before do
      allow(controller).to receive_messages(storage: storage, online_application: online_application)
      allow(Views::Summary).to receive(:new).with(online_application, benefit_answered: true).and_return(summary_view)

      get :show, params: { app_id: app_id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end

    it 'assigns the summary view model' do
      expect(assigns(:summary)).to eql(summary_view)
    end

    context 'when answers are missing' do
      let(:incomplete) { true }

      it 'assigns flash error' do
        expect(flash[:error]).to eql("You’ve made changes. Please answer the highlighted questions to complete your application.")
      end
    end

    it_behaves_like 'cache suppress headers'

    context 'when no question has been answered' do
      let(:storage_started) { false }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
