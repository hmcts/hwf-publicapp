require 'rails_helper'

RSpec.describe Forms::ApplyingOnBehalf do
  subject(:form) { described_class.new(applying_on_behalf: applying_on_behalf) }

  let(:applying_on_behalf) { true }

  describe 'validations' do
    describe 'applying_on_behalf' do
      context 'when true' do
        it { is_expected.to be_valid }
      end

      context 'when false' do
        let(:applying_on_behalf) { false }

        it { is_expected.to be_valid }
      end

      context 'when nil' do
        let(:applying_on_behalf) { nil }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe '#export' do
    subject { form.export }

    context 'when applying_on_behalf is true' do
      let(:applying_on_behalf) { true }

      it { is_expected.to eql(applying_on_behalf: true) }
    end

    context 'when applying_on_behalf is false' do
      let(:applying_on_behalf) { false }

      it { is_expected.to eql(applying_on_behalf: false) }
    end
  end
end
