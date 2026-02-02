require 'rails_helper'

RSpec.describe Forms::Dependent do

  subject(:form) {
    described_class.new(children_number: children_number,
                        children_bands: children_bands)
  }

  let(:children_bands) { [] }

  describe 'validations' do
    let(:children_number) { nil }

    describe 'children' do

      context 'when children_number is not supplied' do
        let(:children_number) { nil }

        it { is_expected.not_to be_valid }
      end

      context 'when children_number is supplied as a non-numeric string' do
        let(:children_number) { 'test' }

        it { is_expected.not_to be_valid }
      end

      context 'when children_number is nil' do
        let(:children_number) { nil }

        it { is_expected.not_to be_valid }
      end

      context 'when children_number is supplied as a number' do
        context 'when it is over 99' do
          let(:children_number) { '100' }

          it { is_expected.not_to be_valid }
        end

        context 'when it is lower then 0' do
          let(:children_number) { '-1' }

          it { is_expected.not_to be_valid }
        end

        context 'when it is less or equal than 99' do
          let(:children_number) { '4' }

          it { is_expected.to be_valid }
        end

        context 'when children_number is supplied and age range is empty' do
          before {
            form.calculation_scheme = Rails.configuration.ucd_schema
          }

          let(:children_number) { '1' }
          let(:children_bands) { [nil] }

          it { is_expected.not_to be_valid }
        end

        context 'when children_number is supplied and age range is filled' do
          before {
            form.calculation_scheme = Rails.configuration.ucd_schema
          }

          let(:children_number) { '1' }
          let(:children_bands) { ["one"] }

          it { is_expected.to be_valid }
        end

        context 'when multiple children_number are supplied with age ranges' do
          before {
            form.calculation_scheme = Rails.configuration.ucd_schema
          }

          let(:children_number) { '3' }
          let(:children_bands) { %w[one one two] }

          it { is_expected.to be_valid }
        end
      end
    end
  end

  describe '#export' do
    subject { form.export }

    let(:children_number) { 3 }

    context 'when children is present' do
      it 'returns hash with children parameter containing children_number' do
        expect(subject).to eql(children: children_number, children_age_band: {})
      end
    end

    context 'ucd changes apply' do
      before {
        form.calculation_scheme = Rails.configuration.ucd_schema
        form.valid?
      }

      let(:children_number) { 4 }
      let(:children_bands) { %w[one two two two] }

      it 'returns hash with children' do
        expect(subject).to eql(children: 4, children_age_band: { one: 1, two: 3 })
      end

      context 'string in the value' do

        it { expect(form).to be_valid }
        it { expect(form.children_age_band[:one]).to eq(1) }
        it { expect(form.children_age_band[:two]).to eq(3) }
      end
    end
  end
end
