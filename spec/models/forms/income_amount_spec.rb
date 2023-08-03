require 'rails_helper'

RSpec.describe Forms::IncomeAmount do
  subject(:form) { described_class.new(amount: amount, min_threshold: min_threshold, max_threshold: max_threshold) }

  let(:min_threshold) { -1000000 }
  let(:max_threshold) { 10000000 }

  let(:amount) { nil }

  describe 'validations' do
    describe 'amount' do
      context 'when no amount set' do
        let(:amount) { nil }

        it { is_expected.not_to be_valid }
      end

      context 'when the amount is set' do
        context 'when less than 0' do
          let(:amount) { -1 }

          it { is_expected.not_to be_valid }
        end

        context 'when more than 1 000 000' do
          let(:amount) { 1000001 }

          it { is_expected.not_to be_valid }
        end

        context 'when within the thresholds' do
          let(:amount) { 3000 }

          it { is_expected.to be_valid }
        end
      end

      context 'when under min threshold' do
        let(:amount) { 5 }
        let(:min_threshold) { 1000 }
        let(:max_threshold) { 3000 }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe '#export' do
    subject { form.export }

    context 'when the amount is set' do
      let(:amount) { 2452 }

      it 'returns hash with income parameter set' do
        expect(subject).to eql(income: amount)
      end
    end

    context 'when the amount is not set' do
      let(:amount) { nil }

      it 'returns an ampty hash' do
        expect(subject).to eql({})
      end
    end
  end
end
