require 'rails_helper'

RSpec.describe Forms::Claim::Et do
  subject(:form) { described_class.new(identifier: identifier) }

  describe 'validations' do
    let(:identifier) { '' }

    describe 'identifier' do
      context 'when not provided' do
        it { is_expected.not_to be_valid }
      end

      context 'when provided' do
        context 'when more than 24 characters' do
          let(:identifier) { 'I' * 25 }

          it { is_expected.not_to be_valid }
        end

        context 'when less than 25 characters provided' do
          let(:identifier) { 'I' * 24 }

          it { is_expected.to be_valid }
        end
      end
    end
  end

  describe '#export' do
    subject { form.export }

    let(:identifier) { 'IDENTIFIER' }

    it 'returns hash with case_number set and probate set to false' do
      expect(subject).to eql(case_number: identifier, probate: false)
    end
  end
end
