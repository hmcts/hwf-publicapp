require 'rails_helper'

RSpec.describe ConfirmationsController, type: :controller do
  let(:session) { double }
  let(:online_application) { double(benefits: true) }
  let(:result) { { result: true, message: 'HWF-010101' } }
  let(:storage_started) { true }
  let(:storage) { double(submission_result: result, time_taken: 600, started?: storage_started) }
  let(:builder) { double(online_application: online_application) }

  before do
    allow(controller).to receive(:session).and_return(session)
    allow(Storage).to receive(:new).with(session).and_return(storage)
    allow(OnlineApplicationBuilder).to receive(:new).with(storage).and_return(builder)
  end

  describe 'GET #show' do
    before do
      get :show
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns the online application model' do
      expect(assigns(:online_application)).to eql(online_application)
    end

    it 'assigns the response object from the session' do
      expect(assigns(:result)).to eql(result)
    end

    include_examples 'cache suppress headers'

    context 'when storage has been cleared' do
      let(:storage_started) { false }
      let(:result) { nil }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #done' do
    before do
      get :done
    end

    it 'renders the show template' do
      expect(response).to render_template(:done)
    end

    it 'assigns the online application model' do
      expect(assigns(:online_application)).to eql(online_application)
    end

    it 'assigns the response object from the session' do
      expect(assigns(:result)).to eql(result)
    end

    include_examples 'cache suppress headers'

    context 'when storage has been cleared' do
      let(:storage_started) { false }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #refund' do
    before do
      get :refund
    end

    it 'renders the show template' do
      expect(response).to render_template(:refund)
    end

    it 'assigns the online application model' do
      expect(assigns(:online_application)).to eql(online_application)
    end

    it 'assigns the response object from the session' do
      expect(assigns(:result)).to eql(result)
    end

    include_examples 'cache suppress headers'

    context 'when storage has been cleared' do
      let(:storage_started) { false }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #et' do
    before do
      get :et
    end

    it 'renders the show template' do
      expect(response).to render_template(:et)
    end

    it 'assigns the online application model' do
      expect(assigns(:online_application)).to eql(online_application)
    end

    it 'assigns the response object from the session' do
      expect(assigns(:result)).to eql(result)
    end

    include_examples 'cache suppress headers'

    context 'when storage has been cleared' do
      let(:storage_started) { false }

      it 'redirects to the home page' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
