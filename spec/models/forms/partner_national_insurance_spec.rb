require 'rails_helper'

RSpec.describe Forms::PartnerNationalInsurance do
  subject(:form_partner_ni) { described_class.new }

  describe 'validations' do
    describe 'number' do
      before { form_partner_ni.partner_ni_number_blank = false }

      context 'when provided' do
        before {
          form_partner_ni.number = 'AB123456A'
        }

        it { expect(form_partner_ni.valid?).to be true }
      end

      context 'when provided in lower case' do
        before { form_partner_ni.number = 'ab123456a' }

        it { expect(form_partner_ni.valid?).to be true }

        describe 'transforms the input to uppercase' do
          before { form_partner_ni.valid? }

          it { expect(form_partner_ni.number).to eql 'AB123456A' }
        end
      end

      context 'when provided with spaces' do
        before do
          form_partner_ni.number = 'AB 12 34 56 A'
          form_partner_ni.valid?
        end

        it { expect(form_partner_ni).to be_valid }

        it 'removes the spaces' do
          expect(form_partner_ni.number).to eq 'AB123456A'
        end
      end

      context 'when provided with an invalid format' do
        before { form_partner_ni.number = 'A1 ' }

        it { expect(form_partner_ni.valid?).to be false }
      end

      context 'when not provided' do
        before {
          form_partner_ni.number = ''
          form_partner_ni.partner_ni_number_blank = false
        }

        it { expect(form_partner_ni.valid?).to be false }
      end

      context 'when not does not have one' do
        before do
          form_partner_ni.number = ''
          form_partner_ni.partner_ni_number_blank = true
        end

        it { expect(form_partner_ni.valid?).to be true }
      end
    end

    describe 'partner_ni_number_blank' do
      before { form_partner_ni.number = 'AB123456A' }

      context 'is valid when provided' do
        before do
          form_partner_ni.partner_ni_number_blank = false
        end

        it { expect(form_partner_ni.valid?).to be true }
      end

      context 'is valid when not provided' do
        before do
          form_partner_ni.partner_ni_number_blank = true
        end

        it { expect(form_partner_ni.valid?).to be true }
      end
    end
  end

  describe '#export' do
    subject { described_class.new(number:, partner_ni_number_blank:).export }

    let(:number) { 'AA123456A' }
    let(:partner_ni_number_blank) { false }

    it 'returns hash with ni_number set' do
      expect(subject).to eql(partner_ni_number: number, partner_ni_number_blank: partner_ni_number_blank)
    end
  end

end
