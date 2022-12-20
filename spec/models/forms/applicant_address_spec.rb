require 'rails_helper'

RSpec.describe Forms::ApplicantAddress do
  subject(:form) { described_class.new(street: street, town: town, postcode: postcode) }

  let(:town) { 'London' }
  let(:street) { '102 Petty France' }
  let(:postcode) { 'LON DON' }

  describe 'validations' do
    describe 'street' do
      context 'when street not provided' do
        let(:street) { '' }

        it { is_expected.not_to be_valid }
      end

      context 'when provided' do
        context 'when more than 99 characters long' do
          let(:street) { 'a' * 100 }

          it { is_expected.not_to be_valid }
        end

        context 'when maximum 99 characters long' do
          let(:street) { 'a' * 99 }

          it { is_expected.to be_valid }
        end
      end
    end

    describe 'town' do
      context 'when town not provided' do
        let(:town) { '' }

        it { is_expected.not_to be_valid }
      end

      context 'when provided' do
        context 'when more than 30 characters long' do
          let(:town) { 'a' * 31 }

          it { is_expected.not_to be_valid }
        end

        context 'when maximum 30 characters long' do
          let(:town) { 'a' * 30 }

          it { is_expected.to be_valid }
        end
      end
    end

    describe 'postcode' do
      context 'when postcode not provided' do
        let(:postcode) { '' }

        it { is_expected.not_to be_valid }
      end

      context 'when provided' do
        context 'when more than 8 characters long' do
          let(:postcode) { 'p' * 9 }

          it { is_expected.not_to be_valid }
        end

        context 'when maximum 8 characters long' do
          let(:postcode) { 'p' * 8 }

          it { is_expected.to be_valid }
        end
      end

    end
  end

  describe '#export' do
    subject { form.export }

    it 'returns hash with address and postcode' do
      expect(subject).to eql(address: "#{street}, #{town}", street: street, town: town, postcode: postcode)
    end
  end

end
