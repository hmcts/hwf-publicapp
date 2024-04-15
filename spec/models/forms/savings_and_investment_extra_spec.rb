require 'rails_helper'

RSpec.describe Forms::SavingsAndInvestmentExtra do
  subject(:form) { described_class.new(over_61: over_61, amount: amount, over_16: over_16) }

  let(:over_61) { true }
  let(:amount) { nil }
  let(:over_16) { nil }

  describe 'validations' do
    describe 'over_61' do
      let(:amount) { 4500 }

      context 'when false' do
        let(:over_61) { false }

        it { is_expected.to be_valid }
      end

      context 'when true' do
        let(:over_61) { true }

        it { is_expected.to be_valid }
      end

      context 'when not set' do
        let(:over_61) { nil }

        it { is_expected.not_to be_valid }
      end

      context 'when something else than true or false' do
        let(:over_61) { 'something' }

        it { is_expected.not_to be_valid }
      end

      context 'under 16' do
        let(:over_16) { false }
        let(:over_61) { true }

        it { is_expected.not_to be_valid }
      end

      context 'over 16' do
        let(:over_16) { true }
        let(:over_61) { true }

        it { is_expected.to be_valid }
      end
    end

    describe 'amount' do
      context 'when over_61 is false' do
        let(:over_61) { false }

        context 'when no amount set' do
          let(:amount) { nil }

          it { is_expected.not_to be_valid }
        end

        context 'when the amount is set' do
          context 'when below the minimum threshold' do
            let(:amount) { 2999 }

            it { is_expected.not_to be_valid }
          end

          context 'ucd changes apply' do
            before {
              form.calculation_scheme = FeatureSwitch::CALCULATION_SCHEMAS[1]
              form.valid?
            }

            let(:amount) { 4249 }

            it { is_expected.not_to be_valid }
          end

          context 'when above the maximum threshold' do
            let(:amount) { 16000 }

            it { is_expected.not_to be_valid }
          end

          context 'when within the thresholds' do
            let(:amount) { 11000 }

            it { is_expected.to be_valid }
          end
        end
      end

      context 'when over_61 is true and no amount is set' do
        let(:over_61) { true }
        let(:amount) { nil }

        it { is_expected.to be_valid }
      end

      context 'when over_61 is not set' do
        let(:over_61) { nil }
        let(:amount) { nil }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe '#export' do
    subject { form.export }

    context 'when over_61 is true' do
      it 'returns hash with over_61 parameter true' do
        expect(subject).to eql(over_61: true)
      end
    end

    context 'when over_61 is false' do
      let(:over_61) { false }
      let(:amount) { 4000 }

      it 'returns hash with over_61 parameter false and amount parameter set' do
        expect(subject).to eql(over_61: false, amount: amount)
      end
    end
  end
end
