require 'rails_helper'

RSpec.describe Forms::LegalRepresentative do
  subject(:form) { described_class.new(legal_representative: legal_representative) }

  let(:legal_representative) { 'litigation_friend' }

  describe 'validations' do
    context 'when litigation_friend' do
      it { is_expected.to be_valid }
    end

    context 'when legal_representative' do
      let(:legal_representative) { 'legal_representative' }

      it { is_expected.to be_valid }
    end

    context 'when blank' do
      let(:legal_representative) { '' }

      it { is_expected.not_to be_valid }
    end

    context 'when invalid value' do
      let(:legal_representative) { 'other' }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#export' do
    subject { form.export }

    context 'when litigation_friend' do
      it { is_expected.to eql(legal_representative: 'litigation_friend') }
    end

    context 'when legal_representative' do
      let(:legal_representative) { 'legal_representative' }

      it { is_expected.to eql(legal_representative: 'legal_representative') }
    end
  end
end
