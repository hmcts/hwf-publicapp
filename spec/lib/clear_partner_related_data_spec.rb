RSpec.describe ClearPartnerRelatedData do
  # rubocop:disable RSpec/LeakyConstantDeclaration, Lint/ConstantDefinitionInBlock
  class TestClass
    include ClearPartnerRelatedData
    def initialize(storage, question)
      @storage = storage
      @question = question
    end
  end
  # rubocop:enable RSpec/LeakyConstantDeclaration,Lint/ConstantDefinitionInBlock

  subject(:service) { TestClass.new(storage, question) }

  context 'when married changed' do
    let(:question) { :marital_status }
    let(:old_online_application) { build(:online_application, married: true) }
    let(:new_online_application) { build(:online_application, married: false) }
    let(:income_params) { { 'applicant' => [1], 'partner' => [2, 3] } }
    let(:dob_params) { { "day" => 1, "month" => 1, "year" => 2000, "partner_day" => 2, "partner_month" => 3, "partner_year" => 2001 } }
    let(:name_params) { { 'first_name' => 'tom', 'partner_first_name' => 'joe', 'partner_last_name' => 'jean' } }

    let(:storage) { Storage.new(session) }
    let(:session_id) { 3 }
    let(:session) { instance_double(ActionDispatch::Request::Session, id: session_id) }
    let(:rails_store) { Rails.cache }

    before {
      allow(session).to receive(:[]).with(:calculation_scheme).and_return Rails.configuration.ucd_schema.to_s
      allow(session).to receive(:[]).with(:started_at).and_return ''
      allow(session).to receive(:[]=)

      rails_store.write("questions-#{session_id}-income_kind", income_params.as_json)
      rails_store.write("questions-#{session_id}-dob", dob_params.as_json)
      rails_store.write("questions-#{session_id}-personal_detail", name_params.as_json)
    }

    describe 'clears partner data' do
      it 'income kind' do
        service.clear_partner_data

        params = rails_store.read("questions-#{session_id}-income_kind")
        expect(params['partner']).to be_blank
      end

      it 'partner dob' do
        service.clear_partner_data
        params = rails_store.read("questions-#{session_id}-dob")
        expect(params['partner_day']).to be_blank
        expect(params['partner_month']).to be_blank
        expect(params['partner_yead']).to be_blank
      end

      it 'partner name' do
        service.clear_partner_data

        params = rails_store.read("questions-#{session_id}-personal_detail")
        expect(params['partner_first_name']).to be_blank
        expect(params['partner_last_name']).to be_blank
      end
    end
  end
end
