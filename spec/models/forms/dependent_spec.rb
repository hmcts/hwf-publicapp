require 'rails_helper'

RSpec.describe Forms::Dependent do

  subject(:form) {
    described_class.new(children: children,
                        children_number: children_number, children_age_band_one: children_age_band_one, children_age_band_two: children_age_band_two)
  }

  let(:children_age_band_one) { 0 }
  let(:children_age_band_two) { 0 }

  describe 'validations' do
    let(:children_number) { nil }

    describe 'children' do

      context 'when true' do
        let(:children) { true }

        context 'when children_number is not supplied' do
          let(:children_number) { '' }

          it { is_expected.not_to be_valid }
        end

        context 'when children_number is supplied as a word' do
          let(:children_number) { 'three' }

          it { is_expected.not_to be_valid }
        end

        context 'when children_number is supplied as a number' do
          context 'when it is over 99' do
            let(:children_number) { '100' }

            it { is_expected.not_to be_valid }
          end

          context 'when it is eql to 0' do
            let(:children_number) { '0' }

            it { is_expected.not_to be_valid }
          end

          context 'when it is lower then 0' do
            let(:children_number) { '-1' }

            it { is_expected.not_to be_valid }
          end

          context 'when it is less or equal than 99' do
            let(:children_number) { '4' }

            it { is_expected.to be_valid }
          end
        end
      end

      context 'when false' do
        let(:children) { false }

        it { is_expected.to be_valid }
      end

      context 'when not a boolean value' do
        let(:children) { 'string' }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe '#export' do
    subject { form.export }

    let(:children_number) { 3 }

    context 'when children is true' do
      let(:children) { true }

      it 'returns hash with children parameter containing children_number' do
        expect(subject).to eql(children: children_number, children_age_band: {})
      end
    end

    context 'when children is false' do
      let(:children) { false }

      it 'returns hash with children parameter containing 0' do
        expect(subject).to eql(children: 0, children_age_band: {})
      end
    end

    context 'when children is nil' do
      let(:children) { nil }

      it 'returns hash with children parameter being nil' do
        expect(subject).to eql(children: nil, children_age_band: {})
      end
    end

    context 'ucd changes apply' do
      before {
        form.calculation_scheme = FeatureSwitch::CALCULATION_SCHEMAS[1]
        form.valid?
      }

      let(:children) { true }
      let(:children_number) { nil }
      let(:children_age_band_one) { 1 }
      let(:children_age_band_two) { 3 }

      it 'returns hash with children' do
        expect(subject).to eql(children: 4, children_age_band: { one: 1, two: 3 })
      end

      context 'string in the value' do
        let(:children) { true }
        let(:children_age_band_one) { ' 1' }
        let(:children_age_band_two) { ' 2' }

        it { expect(form).to be_valid }
        it { expect(form.children_age_band_one).to eq(1) }
        it { expect(form.children_age_band_two).to eq(2) }
      end

    end

  end
end
