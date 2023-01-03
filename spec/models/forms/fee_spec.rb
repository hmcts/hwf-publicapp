require 'rails_helper'

RSpec.describe Forms::Fee do
  subject(:form_fee) { described_class.new }

  describe 'validations' do
    describe 'paid' do
      context 'when true' do
        before { form_fee.paid = true }

        context 'and date_paid is completed' do
          before do
            form_fee.day_date_paid = Time.zone.yesterday.day
            form_fee.month_date_paid = Time.zone.yesterday.month
            form_fee.year_date_paid = Time.zone.yesterday.year
          end

          it { expect(form_fee.valid?).to be true }
        end

        context 'incomplete date' do
          before do
            form_fee.day_date_paid = Time.zone.yesterday.day
            form_fee.month_date_paid = Time.zone.yesterday.month
            form_fee.year_date_paid = Time.zone.yesterday.year
          end

          context 'and day_date_paid is not completed' do
            before { form_fee.day_date_paid = nil }

            it { expect(form_fee.valid?).to be false }
          end

          context 'and month_date_paid is not completed' do
            before { form_fee.month_date_paid = nil }

            it { expect(form_fee.valid?).to be false }
          end

          context 'and year_date_paid is not completed' do
            before { form_fee.year_date_paid = nil }

            it { expect(form_fee.valid?).to be false }
          end
        end
      end

      context 'when false' do
        before { form_fee.paid = false }

        it { expect(form_fee.valid?).to be true }
      end

      context 'when not a boolean value' do
        before { form_fee.paid = 'string' }

        it { expect(form_fee.valid?).to be false }
      end
    end
  end

  describe '#export' do
    subject do
      described_class.new(paid: paid,
                          day_date_paid: date_paid.day,
                          month_date_paid: date_paid.month,
                          year_date_paid: date_paid.year).export
    end

    let(:date_paid) { Date.parse('12/12/2015') }

    context 'when paid is true' do
      let(:paid) { true }

      it 'returns hash with refund true and date_fee_paid set' do
        expect(subject).to eql(refund: true, date_fee_paid: date_paid)
      end
    end

    context 'when paid is false' do
      let(:paid) { false }

      it 'returns hash with refund false dna date_fee_paid nil' do
        expect(subject).to eql(refund: false, date_fee_paid: nil)
      end
    end
  end

end
