require 'rails_helper'

RSpec.describe Forms::IncomeKind do
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

        context 'when children is provided' do
          let(:params) { { applicant: applicant, partner: partner, children: children } }

          context 'when it is empty' do
            let(:children) { [] }

            it { is_expected.to be_valid }
          end

          context 'when it has only values which are allowed' do
            let(:children) { 1 }

            it { is_expected.to be_valid }
          end
        end
      end

      context 'when child benefit is selected' do
        let(:params) { { applicant: applicant, partner: partner, children: children } }

        context 'when no children are selected' do
          let(:applicant) { [3] }
          let(:children) { 0 }

          it { is_expected.not_to be_valid }
        end

        context 'when children are selected' do
          let(:applicant) { [3] }
          let(:children) { 1 }

          it { is_expected.to be_valid }
        end
      end
    end

    context 'ucd changes apply' do
      before {
        form.valid?
      }

      context 'when none and income is selected for applicant' do
        let(:applicant) { [1, described_class.no_income_index] }

        it { is_expected.not_to be_valid }

        context 'when none and income is selected for partner' do
          let(:partner) { [1, described_class.no_income_index] }

          it { is_expected.not_to be_valid }
        end
      end
    end
  end

  describe '.allowed_kinds' do
    subject { described_class.allowed_kinds }

    it 'returns an array of indexes of allowed income kinds' do
      expect(subject).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17])
    end
  end

  describe '.no_income_index' do
    subject { described_class.no_income_index }

    it { is_expected.to eq 17 }
  end

  describe '#none_of_above_selected' do
    subject { form.send(:check_income_and_none_selected, applicant, attribute_name) }

    let(:attribute_name) { :applicant }

    context 'if the kinds count is below 1' do
      let(:applicant) { [1] }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#export' do
    subject { form.export }

    let(:params) { { applicant: applicant, partner: partner } }

    context 'when partner kinds are provided' do
      context 'when the only option for both is "no income"' do
        let(:applicant) { [17] }
        let(:partner) { [17] }

        it 'returns hash with income parameter set to 0' do
          expect(subject[:income]).to be(0)
        end

        it 'returns hash with income_kind text value' do
          expect(subject[:income_kind]).to eq(applicant: ["None of the above"], partner: ["None of the above"])
        end
      end

      context 'when applicant has "no income" but partner does have an income' do
        let(:applicant) { [17] }
        let(:partner) { [1] }

        it 'returns an empty hash' do
          expect(subject[:income]).to be_nil
        end

        it 'returns hash with income_kind text value' do
          expect(subject[:income_kind]).to eq(applicant: ["None of the above"], partner: ["Wages before tax and National Insurance are taken off"])
        end
      end

      context 'when both applicant and partner has other sources than "no income"' do
        let(:applicant) { [1, 17] }
        let(:partner) { [5, 17] }

        it 'returns an empty hash' do
          expect(subject[:income]).to be_nil
        end

        it 'returns hash with income_kind text value' do
          expect(subject[:income_kind]).to eq(applicant: ["Wages before tax and National Insurance are taken off",
                                                          "None of the above"], partner: ["Child Tax Credit", "None of the above"])
        end
      end
    end

    context 'when only applicant kinds are provided' do
      let(:partner) { nil }

      context 'when the only selected option is "no income"' do
        let(:applicant) { [17] }

        it 'returns hash with income parameter set to 0' do
          expect(subject[:income]).to be(0)

        end

        it 'returns hash with income_kind text value' do
          expect(subject[:income_kind]).to eq(applicant: ["None of the above"], partner: [])
        end
      end

      context 'when the selected options do not include "no income"' do
        let(:applicant) { [1, 5] }

        it 'returns an empty hash' do
          expect(subject[:income]).to be_nil
        end

        it 'returns hash with income_kind text value' do
          expect(subject[:income_kind]).to eq(applicant: ["Wages before tax and National Insurance are taken off",
                                                          "Child Tax Credit"], partner: [])
        end
      end

      context 'when the selected options do include "no income"' do
        let(:applicant) { [1, 17] }

        it 'returns an empty hash' do
          expect(subject[:income]).to be_nil
        end

        it 'returns hash with income_kind text value' do
          expect(subject[:income_kind]).to eq(applicant: ["Wages before tax and National Insurance are taken off",
                                                          "None of the above"], partner: [])
        end
      end
    end
  end

  describe '#permitted_attributes' do
    subject { form.permitted_attributes }

    it 'permits the applicant and partner attributes as an array' do
      expect(subject).to eql([applicant: [], partner: [], children: []])
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
