require 'rails_helper'

RSpec.describe Forms::FormName do
  subject(:form) { described_class.new(identifier: identifier, unknown: unknown) }

  let(:unknown) { false }

  describe 'validations' do
    describe 'identifier' do
      context 'when missing' do
        let(:identifier) { nil }

        context 'when the unknown field is false' do
          context 'when the et field is false' do
            it { is_expected.not_to be_valid }
          end
        end

        context 'when the unknown field is true' do
          let(:unknown) { true }

          it { is_expected.to be_valid }
        end
      end

      context 'when filled in' do
        context 'when more than 49 characters' do
          let(:identifier) { 'I' * 50 }

          it { is_expected.not_to be_valid }
        end

        context 'when maximum 49 characters long' do
          let(:identifier) { 'I' * 49 }

          it { is_expected.to be_valid }
        end

        context 'when user types EX160' do
          let(:identifier) { 'EX160' }

          it { is_expected.not_to be_valid }
        end

        context 'when user types ex160' do
          let(:identifier) { 'ex160' }

          it { is_expected.not_to be_valid }
        end

        context 'when user types COP44A' do
          let(:identifier) { 'COP44A' }

          it { is_expected.not_to be_valid }
        end

        context 'when user types COP45A' do
          let(:identifier) { 'COP45A' }

          it { is_expected.to be_valid }
        end
      end
    end
  end

  describe '#export' do
    subject { form.export }

    context 'when identifier is set and not blank' do
      let(:identifier) { 'IDENTIFIER' }

      context 'when the unknown field is true' do
        let(:unknown) { true }

        it 'returns hash with form_name set' do
          expect(subject).to eql(form_name: identifier)
        end
      end

      context 'when the unknown field is false' do
        it 'returns hash with form_name set' do
          expect(subject).to eql(form_name: identifier)
        end
      end
    end

    context 'when identifier is nil' do
      let(:identifier) { nil }

      context 'when the et field is false' do
        it 'returns hash with form_name nil' do
          expect(subject).to eql(form_name: nil)
        end
      end
    end

    context 'when identifier is blank' do
      let(:identifier) { '  ' }

      context 'when the et field is false' do
        it 'returns hash with form_name nil' do
          expect(subject).to eql(form_name: nil)
        end
      end
    end
  end

end
