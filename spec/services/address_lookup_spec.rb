require 'rails_helper'

RSpec.describe AddressLookup do
  subject(:address_lookup) { described_class }

  before {
    stub_request(:post, "https://api.os.uk/oauth2/token/v1").to_return(body: { access_token: "abc" }.to_json)
  }

  describe '#access_token' do
    context 'question' do

      it 'fee_page return nil' do
        expect(address_lookup.access_token(:question)).to be_nil
      end

      it 'applicant_address return data' do
        expect(address_lookup.access_token(:applicant_address)).to eq 'abc'
      end

      it 'legal_representative_detail return data' do
        expect(address_lookup.access_token(:legal_representative_detail)).to eq 'abc'
      end
    end
  end
end
