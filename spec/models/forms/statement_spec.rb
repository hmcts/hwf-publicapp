require 'rails_helper'

RSpec.describe Forms::Statement do
  subject(:form) { described_class.new(signed_by: signed_by) }

  let(:signed_by) { 'applicant' }

  describe 'validations' do
    context 'when applicant' do
      it { is_expected.to be_valid }
    end

    context 'when legal_representative' do
      let(:signed_by) { 'legal_representative' }

      it { is_expected.to be_valid }
    end

    context 'when blank' do
      let(:signed_by) { '' }

      it { is_expected.not_to be_valid }
    end

    context 'when invalid value' do
      let(:signed_by) { 'other' }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#export' do
    subject { form.export }

    context 'when signed_by is applicant' do
      it { is_expected.to eql(statement_signed_by: 'applicant') }
    end

    context 'when signed_by is legal_representative' do
      let(:signed_by) { 'legal_representative' }

      it { is_expected.to eql(statement_signed_by: 'legal_representative') }
    end
  end
end
