require 'rails_helper'

RSpec.describe Forms::NationalInsurance do
  subject(:form_ni) { described_class.new }

  describe 'validations' do
    describe 'number' do
      before { form_ni.ni_number_present = true }

      context 'when provided' do
        before {
          form_ni.number = 'AB123456A'
        }

        it { expect(form_ni.valid?).to be true }
      end

      context 'when provided in lower case' do
        before { form_ni.number = 'ab123456a' }

        it { expect(form_ni.valid?).to be true }

        describe 'transforms the input to uppercase' do
          before { form_ni.valid? }

          it { expect(form_ni.number).to eql 'AB123456A' }
        end
      end

      context 'when provided with spaces' do
        before do
          form_ni.number = 'AB 12 34 56 A'
          form_ni.valid?
        end

        it { expect(form_ni).to be_valid }

        it 'removes the spaces' do
          expect(form_ni.number).to eq 'AB123456A'
        end
      end

      context 'when provided with an invalid format' do
        before { form_ni.number = 'A1 ' }

        it { expect(form_ni.valid?).to be false }
      end

      context 'when not provided' do
        before {
          form_ni.number = ''
          form_ni.ni_number_present = true
        }

        it { expect(form_ni.valid?).to be false }
      end

      context 'when not does not have one' do
        before do
          form_ni.number = ''
          form_ni.ni_number_present = false
        end

        it { expect(form_ni.valid?).to be true }
      end
    end

    describe 'ni_number_present' do
      before { form_ni.number = 'AB123456A' }

      context 'is valid when true' do
        before do
          form_ni.ni_number_present = true
        end

        it { expect(form_ni.valid?).to be true }
      end

      context 'is valid when false' do
        before do
          form_ni.ni_number_present = false
        end

        it { expect(form_ni.valid?).to be true }
      end

      context 'is invalid when not true of false' do
        before do
          form_ni.ni_number_present = nil
        end

        it { expect(form_ni.valid?).to be false }
      end
    end
  end

  describe '#export' do
    subject { described_class.new(number:, ni_number_present:).export }

    let(:number) { 'AA123456A' }
    let(:ni_number_present) { true }

    it 'returns hash with ni_number set' do
      expect(subject).to eql(ni_number: number, ni_number_present:)
    end
  end

end
