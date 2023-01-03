require 'rails_helper'

RSpec.describe Forms::NationalInsurance do
  subject(:form_ni) { described_class.new }

  describe 'validations' do
    describe 'number' do
      context 'when provided' do
        before { form_ni.number = 'AB123456A' }

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
          form_ni.has_ni_number = true
        }

        it { expect(form_ni.valid?).to be false }
      end

      context 'when not does not have one' do
        before do
          form_ni.number = ''
          form_ni.has_ni_number = false
        end

        it { expect(form_ni.valid?).to be true }
      end
    end
  end

  describe '#export' do
    subject { described_class.new(number: number).export }

    let(:number) { 'AA123456A' }

    it 'returns hash with ni_number set' do
      expect(subject).to eql(ni_number: number)
    end
  end

end
