# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Forms::IncomeKind, type: :model do
  subject(:form) { described_class.new(params) }

  let(:params) { {} }

  describe 'validations' do
    let(:partner) { nil }
    let(:params) { { applicant: applicant, partner: partner } }

    context 'when applicant is not provided' do
      let(:applicant) { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when applicant is provided' do
      context 'when it has values which are not allowed' do
        let(:applicant) { [2, 50] }

        it { is_expected.not_to be_valid }
      end

      context 'when it is empty' do
        let(:applicant) { [] }

        it { is_expected.not_to be_valid }
      end

      context 'when it has only values which are allowed' do
        let(:applicant) { [2, 5] }

        it { is_expected.to be_valid }

        context 'when partner is provided' do
          context 'when it has values which are not allowed' do
            let(:partner) { [2, 50] }

            it { is_expected.not_to be_valid }
          end

          context 'when it is empty' do
            let(:partner) { [] }

            it { is_expected.to be_valid }
          end

          context 'when it has only values which are allowed' do
            let(:partner) { [2, 5] }

            it { is_expected.to be_valid }
          end
        end

      end
    end
  end

  describe '.allowed_kinds' do
    subject { described_class.allowed_kinds }

    it 'returns an array of indexes of allowed income kinds' do
      is_expected.to eql([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])
    end
  end

  describe '.no_income_index' do
    subject { described_class.no_income_index }

    it { is_expected.to eq 13 }
  end

  describe '#export' do
    subject { form.export }

    let(:params) { { applicant: applicant, partner: partner } }

    context 'when partner kinds are provided' do
      context 'when the only option for both is "no income"' do
        let(:applicant) { [13] }
        let(:partner) { [13] }

        it 'returns hash with income parameter set to 0' do
          is_expected.to eql(income: 0)
        end
      end

      context 'when applicant has "no income" but partner does have an income' do
        let(:applicant) { [13] }
        let(:partner) { [1] }

        it 'returns an empty hash' do
          is_expected.to eql({})
        end
      end

      context 'when both applicant and partner has other sources than "no income"' do
        let(:applicant) { [1, 13] }
        let(:partner) { [5, 13] }

        it 'returns an empty hash' do
          is_expected.to eql({})
        end
      end
    end

    context 'when only applicant kinds are provided' do
      let(:partner) { nil }

      context 'when the only selected option is "no income"' do
        let(:applicant) { [13] }

        it 'returns hash with income parameter set to 0' do
          is_expected.to eql(income: 0)
        end
      end

      context 'when the selected options do not include "no income"' do
        let(:applicant) { [1, 5] }

        it 'returns an empty hash' do
          is_expected.to eql({})
        end
      end

      context 'when the selected options do include "no income"' do
        let(:applicant) { [1, 13] }

        it 'returns an empty hash' do
          is_expected.to eql({})
        end
      end
    end
  end

  describe '#permitted_attributes' do
    subject { form.permitted_attributes }

    it 'permits the applicant and partner attributes as an array' do
      is_expected.to eql([applicant: [], partner: []])
    end
  end

  describe '#update_attributes' do
    before do
      form.update_attributes(attributes)
    end

    context 'when the attributes contain applicant key' do
      let(:attributes) { { applicant: applicant } }

      context 'when it contains an empty string element' do
        let(:applicant) { [1, '', 5] }

        it 'assigns all but the empty string element' do
          expect(form.applicant).to eql([1, 5])
        end
      end

      context 'when it does not contain an empty string element' do
        let(:applicant) { [1, 5] }

        it 'assigns all the elements' do
          expect(form.applicant).to eql(applicant)
        end
      end
    end

    context 'when the attributes contain partner key' do
      let(:attributes) { { partner: partner } }

      context 'when it contains an empty string element' do
        let(:partner) { [1, '', 5] }

        it 'assigns all but the empty string element' do
          expect(form.partner).to eql([1, 5])
        end
      end

      context 'when it does not contain an empty string element' do
        let(:partner) { [1, 5] }

        it 'assigns all the elements' do
          expect(form.partner).to eql(partner)
        end
      end
    end

    context 'when the attributes do not contain applicant or partner key' do
      let(:attributes) { {} }

      it 'applicant attribute is empty' do
        expect(form.applicant).to be_empty
      end

      it 'partner attribute is empty' do
        expect(form.partner).to be_empty
      end
    end
  end
end
