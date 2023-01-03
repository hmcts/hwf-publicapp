require 'rails_helper'

RSpec.describe Forms::ApplyType do
  subject(:form) { described_class.new(applying_method: applying_method) }

  let(:applying_method) { 'paper' }

  describe 'validations' do

    describe 'applying_method' do
      context 'when paper' do
        it { is_expected.to be_valid }
      end

      context 'when online' do
        let(:applying_method) { 'online' }

        it { is_expected.to be_valid }
      end

      context 'when blank' do
        let(:applying_method) { '' }

        it { is_expected.not_to be_valid }
      end

      context 'when unknown value' do
        let(:applying_method) { 'test' }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe '#export' do
    subject { form.export }

    context 'when applying_method is online' do
      let(:applying_method) { 'online' }

      it 'the returned hash includes applying_method online' do
        expect(subject).to include(applying_method: 'online')
      end
    end

    context 'when applying_method is paper' do

      it 'the returned hash includes applying_method paper' do
        expect(subject).to include(applying_method: 'paper')
      end
    end
  end

end
