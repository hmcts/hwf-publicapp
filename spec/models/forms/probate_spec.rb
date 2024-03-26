require 'rails_helper'

RSpec.describe Forms::Probate do
  subject(:form) { described_class.new(params) }

  let(:params) do
    { kase: kase, deceased_name: deceased_name,
      day_date_of_death: day_date_of_death,
      month_date_of_death: month_date_of_death,
      year_date_of_death: year_date_of_death }
  end

  describe 'validations' do
    let(:deceased_name) { nil }
    let(:day_date_of_death) { nil }
    let(:month_date_of_death) { nil }
    let(:year_date_of_death) { nil }

    describe 'kase' do
      context 'when false' do
        let(:kase) { false }

        it { is_expected.to be_valid }
      end

      context 'when true' do
        let(:kase) { true }
        let(:deceased_name) { 'foo' }
        let(:date_of_death) { Time.zone.today - 1.month }
        let(:day_date_of_death) { date_of_death.day }
        let(:month_date_of_death) { date_of_death.month }
        let(:year_date_of_death) { date_of_death.year }

        context 'time set to past' do
          before { Timecop.freeze(Time.zone.parse("2016-11-01")) }

          after { Timecop.return }

          let(:date_of_death) { 2.days.from_now }
          let(:day_date_of_death) { date_of_death.day }
          let(:month_date_of_death) { date_of_death.month }
          let(:year_date_of_death) { date_of_death.year }

          it { is_expected.not_to be_valid }
        end

        context 'time limit probate' do
          before { Timecop.freeze(Time.zone.parse("1940-01-01")) }

          after { Timecop.return }

          it { is_expected.to be_valid }
        end

        describe 'date of death' do
          describe 'when missing' do
            let(:day_date_of_death) { nil }

            it { is_expected.not_to be_valid }
          end

          describe 'range' do
            context 'exceeds upper bound' do
              let(:date_of_death) { Time.zone.tomorrow }
              let(:day_date_of_death) { date_of_death.day }
              let(:month_date_of_death) { date_of_death.month }
              let(:year_date_of_death) { date_of_death.year }

              it { is_expected.not_to be_valid }
            end
          end
        end

        describe 'deceased_name' do
          context 'when present' do
            context 'when more than 99 characters long' do
              let(:deceased_name) { 'X' * 100 }

              it { is_expected.not_to be_valid }
            end

            context 'when less than 100 characters long' do
              let(:deceased_name) { 'X' * 99 }

              it { is_expected.to be_valid }
            end
          end

          context 'when not set' do
            let(:deceased_name) { nil }

            it { is_expected.not_to be_valid }
          end
        end
      end

      context 'when not a boolean value' do
        let(:kase) { 'string' }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe '#export' do
    subject { form.export }

    let(:deceased_name) { 'Mr. Deceased' }
    let(:date_of_death) { Date.parse('01/01/2016') }
    let(:day_date_of_death) { date_of_death.day }
    let(:month_date_of_death) { date_of_death.month }
    let(:year_date_of_death) { date_of_death.year }

    context 'when kase is true' do
      let(:kase) { true }

      it 'returns hash with probate true and details set' do
        expect(subject).to eql(probate: true, deceased_name: deceased_name, date_of_death: date_of_death)
      end
    end

    context 'when kase is false' do
      let(:kase) { false }

      it 'returns hash with probate false and details nil' do
        expect(subject).to eql(probate: false, deceased_name: nil, date_of_death: nil)
      end
    end
  end
end
