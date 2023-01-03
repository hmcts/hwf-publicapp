require 'rails_helper'

RSpec.describe Forms::Benefit do
  subject(:form_benefit) { described_class.new }

  describe 'validations' do
    describe 'on_benefits' do
      context 'when true' do
        before { form_benefit.on_benefits = true }

        it { expect(form_benefit.valid?).to be true }
      end

      context 'when false' do
        before { form_benefit.on_benefits = false }

        it { expect(form_benefit.valid?).to be true }
      end

      context 'when not a boolean value' do
        before { form_benefit.on_benefits = 'string' }

        it { expect(form_benefit.valid?).to be false }
      end
    end
  end

  describe '#export' do
    subject { described_class.new(on_benefits: on_benefits).export }

    context 'when on_benefits is true' do
      let(:on_benefits) { true }

      it 'returns hash with benefits parameter true' do
        expect(subject).to eql(benefits: true)
      end
    end

    context 'when on_benefits is false' do
      let(:on_benefits) { false }

      it 'returns hash with on_benefits parameter true' do
        expect(subject).to eql(benefits: false)
      end
    end

    context 'when on_benefits is nil' do
      let(:on_benefits) { nil }

      it 'returns hash with on_benefits parameter false' do
        expect(subject).to eql(benefits: false)
      end
    end
  end

end
