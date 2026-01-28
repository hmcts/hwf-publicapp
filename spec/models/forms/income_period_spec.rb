require 'rails_helper'

RSpec.describe Forms::IncomePeriod do
  subject(:form) { described_class.new(amount: amount, income_period: income_period) }

  let(:amount) { 500 }
  let(:income_period) { 'weekly' }

  describe 'validations' do
    context 'when valid' do
      it { is_expected.to be_valid }
    end

    describe 'amount' do
      context 'when blank' do
        let(:amount) { nil }

        it { is_expected.not_to be_valid }
      end

      context 'when negative' do
        let(:amount) { -1 }

        it { is_expected.not_to be_valid }
      end

      context 'when too large' do
        let(:amount) { 1_000_000 }

        it { is_expected.not_to be_valid }
      end

      context 'when zero' do
        let(:amount) { 0 }

        it { is_expected.to be_valid }
      end
    end

    describe 'income_period' do
      context 'when blank' do
        let(:income_period) { nil }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe '#export' do
    subject { form.export }

    it 'returns income and income_period' do
      is_expected.to eql(income: 500, income_period: 'weekly')
    end
  end
end
