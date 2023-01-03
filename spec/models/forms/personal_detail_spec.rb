require 'rails_helper'

RSpec.describe Forms::PersonalDetail do
  subject(:form) { described_class.new(title: title, first_name: first_name, last_name: last_name) }

  let(:title) { 'TITLE' }
  let(:first_name) { 'FIRST NAME' }
  let(:last_name) { 'LAST NAME' }

  describe 'validations' do
    describe 'title' do
      context 'when more than 9 characters long' do
        let(:title) { 'f' * 10 }

        it { is_expected.not_to be_valid }
      end

      context 'when maximum 9 characters long' do
        let(:title) { 'f' * 9 }

        it { is_expected.to be_valid }
      end
    end

    describe 'first_name' do
      context 'when not provided' do
        let(:first_name) { '' }

        it { is_expected.not_to be_valid }
      end

      context 'when provided' do
        context 'when more than 49 characters long' do
          let(:first_name) { 'f' * 50 }

          it { is_expected.not_to be_valid }
        end

        context 'when maximum 49 characters long' do
          let(:first_name) { 'f' * 49 }

          it { is_expected.to be_valid }
        end
      end
    end

    describe 'last_name' do
      context 'when not provided' do
        let(:last_name) { '' }

        it { is_expected.not_to be_valid }
      end

      context 'when provided' do
        context 'when more than 49 characters long' do
          let(:last_name) { 'f' * 50 }

          it { is_expected.not_to be_valid }
        end

        context 'when maximum 49 characters long' do
          let(:last_name) { 'f' * 49 }

          it { is_expected.to be_valid }
        end
      end
    end
  end

  describe '#export' do
    subject { form.export }

    it 'returns hash with title, first_name and last_name' do
      expect(subject).to eql(title: title, first_name: first_name, last_name: last_name)
    end
  end

end
