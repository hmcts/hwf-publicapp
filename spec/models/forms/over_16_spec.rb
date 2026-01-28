require 'rails_helper'

RSpec.describe Forms::Over16 do
  subject(:form) { described_class.new(over_16: over_16) }

  let(:over_16) { true }

  describe 'validations' do
    context 'when true' do
      it { is_expected.to be_valid }
    end

    context 'when false' do
      let(:over_16) { false }

      it { is_expected.to be_valid }
    end

    context 'when nil' do
      let(:over_16) { nil }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#export' do
    subject { form.export }

    context 'when over_16 is true' do
      it { is_expected.to eql(over_16: true) }
    end

    context 'when over_16 is nil' do
      let(:over_16) { nil }

      it { is_expected.to eql(over_16: nil) }
    end

    context 'when over_16 is false' do
      let(:over_16) { false }

      it 'returns over_16 false with overrides for married and ni_number_present' do
        is_expected.to eql(over_16: false, married: false, ni_number_present: false)
      end
    end
  end
end
