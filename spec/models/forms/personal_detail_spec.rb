require 'rails_helper'

RSpec.describe Forms::PersonalDetail do
  subject(:form) { described_class.new(title: title, first_name: first_name, last_name: last_name,
    partner_first_name: partner_first_name, partner_last_name: partner_last_name) }

  let(:title) { 'TITLE' }
  let(:first_name) { 'FIRST NAME' }
  let(:last_name) { 'LAST NAME' }
  let(:partner_first_name) { '' }
  let(:partner_last_name) { '' }

  describe 'validations' do
    context 'ucd changes and married' do
      before do
        form.calculation_scheme = FeatureSwitch::CALCULATION_SCHEMAS[1]
        form.is_married = true
      end

      context 'when title is blank' do
        let(:partner_first_name) { 'first name' }
        let(:partner_last_name) { 'LAST NAME' }

        let(:title) { nil }

        it { is_expected.to be_valid }
      end

      context 'partner first_name blank' do
        let(:partner_first_name) { '' }
        let(:partner_last_name) { 'LAST NAME' }

        it { is_expected.not_to be_valid }
      end
      context 'partner last_name blank' do
        let(:partner_first_name) { '' }
        let(:partner_last_name) { 'LAST NAME' }

        it { is_expected.not_to be_valid }
      end
    end

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

    let(:first_name) { " first name  " }
    let(:trimmed_first_name) { "first name" }
    let(:last_name) { " last name  " }
    let(:trimmed_last_name) { "last name" }

    it 'returns hash with title, first_name and last_name' do
      expect(subject).to eql(title: title, first_name: trimmed_first_name, last_name: trimmed_last_name)
    end
  end

end
