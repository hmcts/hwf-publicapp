require 'rails_helper'

RSpec.describe Forms::Dob do
  subject(:form_dob) { described_class.new }

  context 'partner' do
    describe 'validations' do
      before do
        form_dob.day = '23'
        form_dob.month = '01'
        form_dob.year = '1980'
        form_dob.is_married = true
        form_dob.ni_number_present = true
      end

      it { expect(form_dob.valid?).to be false }

      context 'valid dobs' do
        before do
          form_dob.partner_day = '23'
          form_dob.partner_month = '01'
          form_dob.partner_year = '1980'
        end

        it { expect(form_dob.valid?).to be true }
      end

      context 'zero dobs' do
        describe 'partner day is zero' do
          before do
            form_dob.partner_day = '0'
            form_dob.partner_month = '01'
            form_dob.partner_year = '1980'
          end

          it { expect(form_dob.valid?).to be false }
        end

        describe 'partner month is zero' do
          before do
            form_dob.partner_day = '23'
            form_dob.partner_month = '0'
            form_dob.partner_year = '1980'
          end

          it { expect(form_dob.valid?).to be false }
        end

        describe 'partner year is zero' do
          before do
            form_dob.partner_day = '23'
            form_dob.partner_month = '01'
            form_dob.partner_year = '0'
          end

          it { expect(form_dob.valid?).to be false }
        end

        describe 'day, month, year are zero' do
          before do
            form_dob.partner_day = '0'
            form_dob.partner_month = '0'
            form_dob.partner_year = '0'
          end

          it { expect(form_dob.valid?).to be false }
        end

      end

      context 'blank dobs' do
        before do
          form_dob.partner_day = '23'
          form_dob.partner_month = ''
          form_dob.partner_year = '1980'
        end

        it { expect(form_dob.valid?).to be false }
      end

      context 'too old dobs' do
        before do
          form_dob.partner_day = '23'
          form_dob.partner_month = ''
          form_dob.partner_year = '1900'
        end

        it { expect(form_dob.valid?).to be false }
      end

      context 'no NI present' do
        before do
          form_dob.ni_number_present = false
        end

        it { expect(form_dob.valid?).to be true }
      end

      context 'NI present with empty partner details' do
        before do
          form_dob.ni_number_present = true
        end

        it { expect(form_dob.valid?).to be false }
      end

    end
  end

  describe 'validations' do
    describe 'date_of_birth' do
      context 'when not blank' do
        before do
          form_dob.day = '23'
          form_dob.month = '01'
          form_dob.year = '1980'
        end

        it { expect(form_dob.valid?).to be true }
      end

      context 'when a non date value' do
        before { form_dob.day = 'some string' }

        it { expect(form_dob.valid?).not_to be true }

        describe 'error message' do

          context 'when a string is provided' do
            before { form_dob.valid? }

            let(:error) { ['Enter the date in this format DD/MM/YYYY'] }

            it { expect(form_dob.errors.messages[:date_of_birth]).to eq error }
          end

          context 'when a recent date is provided' do
            let(:today) { Time.zone.today }
            let(:young_error) do
              [I18n.t('activemodel.errors.models.forms/dob.attributes.date_of_birth.too_young', minimum_age: Forms::Dob::MINIMUM_AGE)]
            end

            before do
              form_dob.day = today.day
              form_dob.month = today.month
              form_dob.year = today.year
              form_dob.valid?
            end

            it { expect(form_dob.errors.messages[:date_of_birth]).to eq young_error }
          end

          context 'when a date too far in the past is provided' do
            let(:old_date) { 121.years.ago }
            let(:old_error) do
              [I18n.t('activemodel.errors.models.forms/dob.attributes.date_of_birth.too_old')]
            end

            before do
              form_dob.day = old_date.day
              form_dob.month = old_date.month
              form_dob.year = old_date.year

              form_dob.valid?
            end

            it { expect(form_dob.errors.messages[:date_of_birth]).to eq old_error }
          end
        end
      end

      context 'when passed a two digit year' do
        before do
          form_dob.day = '1'
          form_dob.month = '11'
          form_dob.year = '80'
        end

        it { expect(form_dob.valid?).not_to be true }

        it 'returns an error message, if omitted' do
          form_dob.valid?
          expect(form_dob.errors[:date_of_birth]).to eq ['Enter the date in this format DD/MM/YYYY']
        end
      end

      context 'when day blank' do
        before { form_dob.day = '' }

        it { expect(form_dob.valid?).to be false }
      end

      context 'when month blank' do
        before { form_dob.month = '' }

        it { expect(form_dob.valid?).to be false }
      end

      context 'when year blank' do
        before { form_dob.year = '' }

        it { expect(form_dob.valid?).to be false }
      end

      context 'when the over_66 is checked and age is below 66' do
        let(:over_66) { true }

        before do
          form_dob.day = '01'
          form_dob.month = '01'
          form_dob.year = '1999'
          form_dob.partner_day = '01'
          form_dob.partner_month = '01'
          form_dob.partner_year = '1999'
          form_dob.over_66 = over_66
          form_dob.is_married = is_married
          form_dob.ni_number_present = true
        end

        context 'when is married' do
          let(:is_married) { true }

          it { expect(form_dob.valid?).not_to be true }

          it 'returns an error message' do
            form_dob.valid?
            expect(form_dob.errors.messages[:date_of_birth]).to eq ['Enter date of birth for age 66 years or above for you or your partner (as stated in Step 12)']
          end
        end

        context 'when is not married' do
          let(:is_married) { false }

          it { expect(form_dob.valid?).not_to be true }

          it 'returns an error message' do
            form_dob.valid?
            expect(form_dob.errors.messages[:date_of_birth]).to eq ['Enter date of birth for age 66 years or above (as stated in Step 12)']
          end
        end
      end

      context 'when the over_66 is checked and one of the ages is above 66' do
        let(:over_66) { true }

        before do
          form_dob.day = '23'
          form_dob.month = '01'
          form_dob.year = '1940'
          form_dob.partner_day = '01'
          form_dob.partner_month = '01'
          form_dob.partner_year = '1999'
        end

        context 'when is married' do
          let(:is_married) { true }

          before do
            form_dob.day = '01'
            form_dob.month = '01'
            form_dob.year = '1999'
            form_dob.partner_day = '23'
            form_dob.partner_month = '01'
            form_dob.partner_year = '1940'
          end

          it { expect(form_dob.valid?).to be true }
        end

        context 'when is not married' do
          let(:is_married) { false }

          it { expect(form_dob.valid?).to be true }
        end
      end

      context 'when the over_66 is not checked and age is below 66' do
        let(:over_66) { false }

        before do
          form_dob.day = '01'
          form_dob.month = '01'
          form_dob.year = '1999'
          form_dob.partner_day = '01'
          form_dob.partner_month = '01'
          form_dob.partner_year = '1999'
          form_dob.over_66 = over_66
          form_dob.is_married = is_married
          form_dob.ni_number_present = true
        end

        context 'when is married' do
          let(:is_married) { true }

          it { expect(form_dob.valid?).to be true }
        end

        context 'when is not married' do
          let(:is_married) { false }

          it { expect(form_dob.valid?).to be true }
        end
      end

      context 'when the over_66 is not checked and age is above 66' do
        let(:over_66) { false }

        before do
          form_dob.day = '01'
          form_dob.month = '01'
          form_dob.year = '1940'
          form_dob.partner_day = '01'
          form_dob.partner_month = '01'
          form_dob.partner_year = '1940'
          form_dob.over_66 = over_66
          form_dob.is_married = is_married
          form_dob.ni_number_present = true
        end

        context 'when is married' do
          let(:is_married) { true }

          it { expect(form_dob.valid?).not_to be true }

          it 'returns an error message' do
            form_dob.valid?
            expect(form_dob.errors.messages[:date_of_birth]).to eq ['You have stated that you or your partner are not 66 years or older. Please change your response or check that these dates of birth are correct']
          end
        end

        context 'when is not married' do
          let(:is_married) { false }

          it { expect(form_dob.valid?).not_to be true }

          it 'returns an error message' do
            form_dob.valid?
            expect(form_dob.errors.messages[:date_of_birth]).to eq ['You have stated that you are not 66 years or older. Please change your response or check that this date of birth is correct']
          end
        end
      end

      context 'when the over_16 is checked and age is below 16' do
        let(:over_16) { 'true' }
        let(:today) { Time.zone.today }

        before do
          form_dob.day = today.day
          form_dob.month = today.month
          form_dob.year = today.year - 15
          form_dob.over_16 = over_16
        end

        it { expect(form_dob.valid?).not_to be true }

        it 'returns an error message' do
          form_dob.valid?
          expect(form_dob.errors.messages[:date_of_birth]).to eq ['Enter date of birth for age above 16 (as stated in step 6)']
        end
      end

      context 'when the over_16 is checked and age is 16 today' do
        let(:over_16) { 'true' }
        let(:today) { Time.zone.today }

        before do
          form_dob.day = today.day
          form_dob.month = today.month
          form_dob.year = today.year - 16
          form_dob.over_16 = over_16
        end

        it { expect(form_dob.valid?).to be true }
      end

      context 'when the over_16 is false and age is 16 today' do
        let(:over_16) { 'false' }
        let(:today) { Time.zone.today }

        before do
          form_dob.day = today.day
          form_dob.month = today.month
          form_dob.year = today.year - 16
          form_dob.over_16 = over_16
        end

        it { expect(form_dob.valid?).not_to be true }

        it 'returns an error message' do
          form_dob.valid?
          expect(form_dob.errors.messages[:date_of_birth]).to eq ['Enter date of birth for age under 16 (as stated in step 6)']
        end

      end
    end
  end

  describe '#export' do
    subject do
      described_class.new(day: '01', month: '01', year: '1980').export
    end

    let(:date_of_birth) { Date.parse('01/01/1980') }

    it 'returns hash with date_of_birth' do
      expect(subject).to eql(date_of_birth: date_of_birth, partner_date_of_birth: nil)
    end
  end
end
