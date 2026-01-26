require 'rails_helper'

RSpec.describe Storage do
  subject(:storage) { described_class.new(session, options) }

  let(:current_time) { Time.zone.now.change(usec: 0) }
  let(:options) { {} }

  let(:mock_session) do
    Class.new(Hash) do
      def destroy; end
    end
  end

  describe '#initialize' do
    subject(:frozen_storage) do
      travel_to(current_time) do
        storage
      end
    end

    let(:session) { mock_session[used_at: used_at.to_s, started_at: started_at.to_s] }

    context 'when the storage is requested to be cleared' do
      let(:started_at) { current_time - 5.minutes }
      let(:used_at) { current_time - 1.minute }
      let(:options) { { clear: true } }

      before do
        allow(session).to receive(:destroy)
        frozen_storage
      end

      it 'clears the session' do
        expect(session).to have_received(:destroy)
      end

      it 'stores the current time to the session, as time of last used' do
        expect(session[:used_at]).to eql(current_time)
      end
    end

    context 'when the storage is not requested to be cleared' do
      context 'when the storage has been started' do
        let(:started_at) { current_time }

        context 'when it was used more than 60 minutes ago' do
          let(:used_at) { current_time - 61.minutes }

          before { allow(session).to receive(:destroy) }

          it 'raises an error and clears the session' do
            expect { frozen_storage }.to raise_error(Storage::Expired)
          end
        end

        context 'when it was used less than 60 minutes ago' do
          let(:used_at) { current_time - 59.minutes }

          before { frozen_storage }

          it 'stores the current time to the session, as time of last used' do
            expect(session[:used_at]).to eql(current_time)
          end
        end

        context 'when the storage was just initialised for the first time' do
          let(:session) { {} }

          before { frozen_storage }

          it 'stores the current time to the session, as time of last used' do
            expect(session[:used_at]).to eql(current_time)
          end
        end
      end

      context 'when the storage has not been started' do
        let(:started_at) { nil }
        let(:used_at) { nil }

        before { frozen_storage }

        it 'stores the current time to the session, as time of last used' do
          expect(session[:used_at]).to eql(current_time)
        end
      end
    end
  end

  describe '#clear' do
    let(:session) { instance_double(ActionDispatch::Request::Session, id: session_id, destroy: true) }
    let(:rails_store) { Rails.cache }
    let(:session_id) { 2 }
    let(:session_two_id) { 3 }
    let(:store_data) {
      rails_store.write("questions-#{session_id}-over_16", { 'married' => false, 'over_16' => false }.as_json)
      rails_store.write("questions-#{session_id}-savings_and_investment", { 'choice' => 'between' }.as_json)
      rails_store.write("questions-#{session_two_id}-over_16", { 'married' => false, 'over_16' => false }.as_json)
      rails_store.write("questions-#{session_two_id}-savings_and_investment", { 'choice' => 'between' }.as_json)
    }

    before do
      store_data

      allow(session).to receive(:[]).with(:calculation_scheme).and_return Rails.configuration.ucd_schema.to_s
      allow(session).to receive(:[]).with(:started_at).and_return ''
      allow(session).to receive(:[]=)

      storage.clear
    end

    it 'clears forms only for the session' do
      expect(rails_store.read("questions-#{session_id}-over_16")).to be_nil
      expect(rails_store.read("questions-#{session_id}-savings_and_investment")).to be_nil

      expect(rails_store.read("questions-#{session_two_id}-over_16")).to eq({ "married" => false, "over_16" => false })
      expect(rails_store.read("questions-#{session_two_id}-savings_and_investment")).to eq({ "choice" => "between" })
    end
  end

  describe '#start' do
    let(:session) { {} }

    before do
      travel_to(current_time) do
        storage.start
      end
    end

    it 'sets started_at to the session as the current time' do
      expect(session).to include(started_at: current_time)
    end
  end

  describe '#started?' do
    subject { storage.started? }

    context 'when the session has started_at timestamp setup' do
      let(:session) { { started_at: current_time } }

      it { is_expected.to be true }
    end

    context 'when there started_at timestamp on the session' do
      let(:session) { { another: 'key' } }

      it { is_expected.to be false }
    end
  end

  context 'questions' do
    let(:id) { 'ID' }
    let(:rails_store) { Rails.cache }
    let(:session) { instance_double(ActionDispatch::Request::Session, id: id) }

    before do
      allow(session).to receive(:[]).with(:started_at).and_return ''
      allow(session).to receive(:[]=)
      storage.save_form(form)
    end

    describe '#save_form' do
      let(:json_data) { { some: 'data' } }
      let(:form) { instance_double(Forms::Benefit, id: id, as_json: json_data) }

      before { storage.save_form(form) }

      it 'sets the json data to the session' do
        question = rails_store.read("questions-#{session.id}-#{form.id}")
        expect(question).to eql(json_data)
      end
    end

    describe '#load_form' do
      let(:json_data) { { some: 'data' } }

      let(:form) { instance_double(Forms::Benefit, id: id, update_attributes: nil) }

      before do
        rails_store.write("questions-#{id}-#{form.id}", json_data)
      end

      context 'when the data with the form id is in the session' do
        it 'updates the form with the data' do
          storage.load_form(form)
          expect(form).to have_received(:update_attributes).with(json_data)
        end
      end

      context 'when there is no data with the form id in the session' do
        it 'updates the form with an empty hash' do
          form_2 = instance_double(Forms::Benefit, id: 1, update_attributes: nil)
          storage.load_form(form_2)
          expect(form_2).to have_received(:update_attributes).with({})
        end
      end
    end

    describe '#clear_form' do
      let(:json_data) { { some: 'data' } }
      let(:form) { instance_double(Forms::Benefit, id: id, update_attributes: nil) }

      before do
        rails_store.write("questions-#{id}-#{form.id}", json_data)
        storage.clear_form(form.id)
      end

      context 'when there is a question stored with that id' do
        it 'removes the question from the session' do
          question = rails_store.read("questions-#{id}-#{form.id}")
          expect(question).to be_nil
        end
      end
    end
  end

  describe '#submission_result=' do
    let(:result) { double }
    let(:session) { {} }

    before do
      storage.submission_result = result
    end

    it 'stores the submission_result in the session' do
      expect(session[:submission_result]).to eql(result)
    end
  end

  describe '#submission_result' do
    subject { storage.submission_result }

    let(:result) { double }

    context 'when there is a submission_result stored in the session' do
      let(:session) { { submission_result: result } }

      it { is_expected.to eql(result) }
    end

    context 'when there is no submission_result stored in the session' do
      let(:session) { {} }

      it { is_expected.to be_nil }
    end
  end

  describe 'page_path' do
    let(:session) { { 'session_id' => 123 } }

    before { storage.store.write('page_path-123', []) }

    context 'store page' do
      it 'store path' do
        storage.store_page_path('page_123', 'page1')
        expect(storage.store.read('page_path-123')).to eq [{ "page1" => "page_123" }]
      end
    end

    context 'step_back' do
      it 'loads previous url' do
        storage.store_page_path('page_1_url', 'page1')
        storage.store_page_path('page_2_url', 'page2')
        expect(storage.load_step_back('page2')).to eq 'page_1_url'
      end

      it 'loads url for previous page if we skip there directly' do
        storage.store_page_path('page_1_url', 'page1')
        storage.store_page_path('page_2_url', 'page2')
        storage.store_page_path('page_3_url', 'page3')
        storage.store_page_path('page_4_url', 'page4')
        expect(storage.load_step_back('page2')).to eq 'page_1_url'
      end
    end
  end
end
