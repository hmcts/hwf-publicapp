require 'rails_helper'

RSpec.describe Storage do
  subject(:storage) { described_class.new(session, app_id, options) }

  let(:current_time) { Time.zone.now.change(usec: 0) }
  let(:options) { {} }
  let(:app_id) { SecureRandom.uuid }
  let(:session_id) { SecureRandom.uuid }
  let(:session) { mock_session.new.tap { |s| s.id = session_id } }
  let(:mock_session) do
    Class.new(Hash) do
      attr_accessor :id

      def destroy; end
    end
  end
  let(:rails_store) { Rails.cache }
  let(:metadata_key) { "metadata-#{session_id}-#{app_id}" }

  describe '#initialize' do
    subject(:frozen_storage) do
      travel_to(current_time) do
        storage
      end
    end

    before do
      rails_store.write(metadata_key, { started_at: started_at, used_at: used_at })
    end

    context 'when the storage is requested to be cleared' do
      let(:started_at) { current_time - 5.minutes }
      let(:used_at) { current_time - 1.minute }
      let(:options) { { clear: true } }

      before { frozen_storage }

      it 'clears the application metadata from redis' do
        expect(frozen_storage.started?).to be false
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

          it 'raises an error and clears the application metadata' do
            expect { frozen_storage }.to raise_error(Storage::Expired)
            expect(rails_store.read(metadata_key)).to be_nil
          end
        end

        context 'when it was used less than 60 minutes ago' do
          let(:used_at) { current_time - 59.minutes }

          before { frozen_storage }

          it 'stores the current time as time of last used' do
            expect(rails_store.read(metadata_key)[:used_at]).to eql(current_time)
            expect(session[:used_at]).to eql(current_time)
          end
        end
      end

      context 'when the storage has not been started' do
        let(:started_at) { nil }
        let(:used_at) { nil }

        before { frozen_storage }

        it 'does not raise and stores the current time to the session' do
          expect(session[:used_at]).to eql(current_time)
        end
      end
    end
  end

  describe '#start' do
    before do
      travel_to(current_time) do
        storage.start
      end
    end

    it 'sets started_at in the application metadata as the current time' do
      expect(rails_store.read(metadata_key)[:started_at]).to eql(current_time)
    end

    it 'keeps the metadata for twice the session lifetime, for the expiry message' do
      allow(rails_store).to receive(:write).and_call_original
      storage.start
      expect(rails_store).to have_received(:write).with(
        metadata_key, hash_including(:started_at),
        hash_including(expires_in: Settings.session.expires_in_minutes * 60 * 2)
      )
    end
  end

  describe '#started?' do
    subject { storage.started? }

    context 'when the application has been started' do
      before { described_class.new(session, app_id).start }

      it { is_expected.to be true }
    end

    context 'when there is no metadata stored for the application id' do
      it { is_expected.to be false }
    end

    context 'when the same application id was started under another session' do
      before do
        other_session = mock_session.new.tap { |s| s.id = SecureRandom.uuid }
        described_class.new(other_session, app_id).start
      end

      it { is_expected.to be false }
    end
  end

  describe 'application isolation within one session' do
    let(:other_app_id) { SecureRandom.uuid }
    let(:other_storage) { described_class.new(session, other_app_id) }
    let(:form) { instance_double(Forms::Benefit, id: 'benefit', as_json: { 'benefit' => true }) }

    before do
      storage.start
      storage.save_form(form)
      other_storage.start
    end

    it 'scopes forms to their own application' do
      loaded = instance_double(Forms::Benefit, id: 'benefit', update_attributes: nil)
      other_storage.load_form(loaded)
      expect(loaded).to have_received(:update_attributes).with({})
    end

    it 'clearing one application leaves the other untouched' do
      other_storage.clear
      expect(other_storage.started?).to be false
      expect(storage.started?).to be true
      expect(rails_store.read("questions-#{session_id}-#{app_id}-benefit")).to eql('benefit' => true)
    end
  end

  describe '#clear' do
    let(:other_app_key) { "questions-#{session_id}-#{SecureRandom.uuid}-over_16" }

    before do
      storage.save_calculation_scheme(Rails.configuration.ucd_schema.to_s)
      rails_store.write("questions-#{session_id}-#{app_id}-over_16", { 'over_16' => false }.as_json)
      rails_store.write(other_app_key, { 'over_16' => true }.as_json)

      storage.clear
    end

    it 'clears forms only for this application' do
      expect(rails_store.read("questions-#{session_id}-#{app_id}-over_16")).to be_nil
      expect(rails_store.read(other_app_key)).to eq('over_16' => true)
    end
  end

  context 'questions' do
    let(:form_id) { 'benefit' }
    let(:form_key) { "questions-#{session_id}-#{app_id}-#{form_id}" }
    let(:json_data) { { some: 'data' } }

    describe '#save_form' do
      let(:form) { instance_double(Forms::Benefit, id: form_id, as_json: json_data) }

      before { storage.save_form(form) }

      it 'stores the json data under the session and application scoped key' do
        expect(rails_store.read(form_key)).to eql(json_data)
      end

      it 'expires the cached answers after the session lifetime' do
        allow(rails_store).to receive(:write).and_call_original
        storage.save_form(form)
        expect(rails_store).to have_received(:write).with(
          form_key, json_data,
          hash_including(expires_in: Settings.session.expires_in_minutes * 60)
        )
      end
    end

    describe '#load_form' do
      let(:form) { instance_double(Forms::Benefit, id: form_id, update_attributes: nil) }

      before do
        rails_store.write(form_key, json_data)
      end

      context 'when the data with the form id is stored' do
        it 'updates the form with the data' do
          storage.load_form(form)
          expect(form).to have_received(:update_attributes).with(json_data)
        end
      end

      context 'when there is no data with the form id' do
        it 'updates the form with an empty hash' do
          form_2 = instance_double(Forms::Benefit, id: 'other', update_attributes: nil)
          storage.load_form(form_2)
          expect(form_2).to have_received(:update_attributes).with({})
        end
      end
    end

    describe '#clear_form' do
      let(:form) { instance_double(Forms::Benefit, id: form_id) }

      before do
        rails_store.write(form_key, json_data)
        storage.clear_form(form.id)
      end

      it 'removes the stored form' do
        expect(rails_store.read(form_key)).to be_nil
      end
    end
  end

  describe 'calculation scheme' do
    it 'persists the scheme in the application metadata' do
      storage.save_calculation_scheme('scheme')
      expect(described_class.new(session, app_id).load_calculation_scheme).to eql('scheme')
    end
  end

  describe '#submission_result' do
    let(:result) { { result: true } }

    context 'when there is a submission_result stored' do
      before { storage.submission_result = result }

      it 'returns it, also from a fresh instance for the same application' do
        expect(storage.submission_result).to eql(result)
        expect(described_class.new(session, app_id).submission_result).to eql(result)
      end
    end

    context 'when there is no submission_result stored' do
      it { expect(storage.submission_result).to be_nil }
    end
  end

  describe 'page_path' do
    let(:page_path_key) { "page_path-#{session_id}-#{app_id}" }

    context 'store page' do
      it 'store path under the session and application scoped key' do
        storage.store_page_path('page_123', 'page1')
        expect(storage.store.read(page_path_key)).to eq [{ "page1" => "page_123" }]
      end

      it 'expires the page path after the session lifetime' do
        allow(storage.store).to receive(:write).and_call_original
        storage.store_page_path('page_123', 'page1')
        expect(storage.store).to have_received(:write).with(
          page_path_key, anything,
          hash_including(expires_in: Settings.session.expires_in_minutes * 60)
        )
      end

      it 'keeps a separate history per application' do
        other_storage = described_class.new(session, SecureRandom.uuid)
        storage.store_page_path('page_1_url', 'page1')
        other_storage.store_page_path('other_page_url', 'other_page')

        expect(storage.store.read(page_path_key)).to eq [{ "page1" => "page_1_url" }]
        expect(storage.load_step_back('page1')).to be_nil
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
