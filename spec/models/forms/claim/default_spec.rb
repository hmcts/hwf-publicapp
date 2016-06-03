require 'rails_helper'

RSpec.describe Forms::Claim::Default, type: :model do
  subject(:form) { described_class.new(number: number, identifier: identifier) }

  describe 'validations' do
    let(:identifier) { '' }

    describe 'number' do
      context 'when true' do
        let(:number) { true }

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

        context 'when false' do
          let(:number) { false }

          it { is_expected.to be_valid }
        end

        context 'when not a boolean value' do
          let(:number) { 'string' }

          it { is_expected.not_to be_valid }
        end
      end
    end
  end

  describe '#export' do
    let(:identifier) { 'IDENTIFIER' }

    subject { form.export }

    context 'when number is true' do
      let(:number) { true }

      it 'returns hash with case_number set' do
        is_expected.to eql(case_number: identifier)
      end
    end

    context 'when number is false' do
      let(:number) { false }

      it 'returns hash with case_number nil' do
        is_expected.to eql(case_number: nil)
      end
    end
  end
end
