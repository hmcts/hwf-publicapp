require 'rails_helper'

RSpec.describe SummariesController do

  describe 'GET #show' do
    let(:storage_started) { true }
    let(:storage) { instance_double(Storage, started?: storage_started) }
    let(:online_application) { build(:online_application) }
    let(:summary_view) { double('summary_view', income_validation_fails?: income_fails?) }
    let(:income_fails?) { false }

    before do
      allow(controller).to receive_messages(storage: storage, online_application: online_application)
      allow(Views::Summary).to receive(:new).with(online_application).and_return(summary_view)

      get :show
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

    context 'failed income' do
      let(:income_fails?) { true }

      it 'assigns flash error' do
        expect(flash[:error]).to eql("You’ve made changes. Please answer the highlighted questions to complete your application.")
      end
    end

    include_examples 'cache suppress headers'

    context 'when no question has been answered' do
      let(:storage_started) { false }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
