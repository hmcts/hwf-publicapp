require 'rails_helper'

RSpec.describe Forms::MaritalStatus do
  subject(:form_marital_status) { described_class.new }

  describe 'validations' do
    describe 'married' do
      context 'when true' do
        before { form_marital_status.married = true }

        it { expect(form_marital_status.valid?).to be true }
      end

      context 'when false' do
        before { form_marital_status.married = false }

        it { expect(form_marital_status.valid?).to be true }
      end

      context 'when not a boolean value' do
        before { form_marital_status.married = 'test' }

        it { expect(form_marital_status.valid?).to be false }
      end

      context 'when nil' do
        before { form_marital_status.married = nil }

        it { expect(form_marital_status.valid?).to be false }
      end
    end
  end

  describe '#export' do
    subject { described_class.new(married: married).export }

    context 'when married is true' do
      let(:married) { true }

      it 'returns hash with married parameter true' do
        expect(subject).to eql(married: true)
      end
    end

    context 'when married is false' do
      let(:married) { false }

      it 'returns hash with married parameter true' do
        expect(subject).to eql(married: false)
      end
    end
  end
end
