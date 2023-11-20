require 'rails_helper'

RSpec.describe ClearDownstreamQuestions do
  subject(:service) { described_class.new(storage, question) }

  describe '#for_changes' do
    let(:storage) { instance_double(Storage, clear_form: nil, clear_forms: nil) }

    before do
      service.for_changes(old_online_application, new_online_application)
    end

    context 'when the question is "dependent"' do
      let(:question) { :dependent }
      let(:old_online_application) { build(:online_application, children: 2) }

      context 'when the amount of children has changed' do
        let(:new_online_application) { build(:online_application, children: 1) }

        describe 'clears income_range and income_amount questions' do
          it { expect(storage).to have_received(:clear_forms).with([:income_range, :income_amount]) }
        end
      end

      context 'when the amount of children has not changed' do
        let(:new_online_application) { build(:online_application, children: 2) }

        it 'does not clear any questions' do
          expect(storage).not_to have_received(:clear_form)
        end
      end
    end

    context 'when the question is "income_kind"' do
      let(:question) { :income_kind }
      let(:old_online_application) { build(:online_application, income: 1400) }

      context 'when the income has changed to 0' do
        let(:new_online_application) { build(:online_application, income: 0) }

        describe 'clears income_range and income_amount questions' do
          it { expect(storage).to have_received(:clear_forms).with([:income_range, :income_amount]) }
        end
      end

      context 'when the income has not changed' do
        let(:new_online_application) { build(:online_application, income: 1400) }

        it 'does not clear any questions' do
          expect(storage).not_to have_received(:clear_form)
        end
      end
    end

    context 'when the question is "income_range"' do
      let(:question) { :income_range }
      let(:old_online_application) { build(:online_application, :income_between_thresholds) }

      context 'when the range has changed' do
        let(:new_online_application) { build(:online_application, :income_below_thresholds) }

        it 'clears income_amount questions' do
          expect(storage).to have_received(:clear_form).with(:income_amount)
        end
      end
    end

    context 'when the question is "benefit" and is set to true' do
      let(:question) { :benefit }
      let(:old_online_application) { build(:online_application) }
      let(:new_online_application) { build(:online_application, benefits: benefit_value) }

      context 'set to true' do
        let(:benefit_value) { true }

        it 'clears income_amount questions' do
          expect(storage).to have_received(:clear_forms).with([:income_range, :income_amount, :income_kind, :dependent])
        end
      end

      context 'set to false' do
        let(:benefit_value) { false }

        it 'clears income_amount questions' do
          expect(storage).not_to have_received(:clear_forms).with([:income_range, :income_amount, :income_kind, :dependent])
        end
      end
    end

    context 'when the ni is present' do
      let(:question) { :dob }
      let(:old_online_application) {
        build(:online_application, ho_number: 'L1234567', ni_number: 'SN123456A')
      }
      let(:new_online_application) { build(:online_application) }

      context 'and the HO number should be nil' do
        it 'clears home office questions' do
          expect(storage).to have_received(:clear_form).with(:home_office)
        end
      end

      context 'and the HO number but the ni_number_present is false' do
        let(:old_online_application) {
          build(:online_application, ho_number: 'L1234567',
                                     ni_number: 'SN123456A', ni_number_present: false)
        }

        it 'clears national insurance questions' do
          expect(storage).to have_received(:clear_form).with(:national_insurance)
        end
      end
    end

    context 'when the legal representation is present' do
      let(:question) { :legal_representative }
      let(:old_online_application) { build(:online_application, legal_representative: 'litigation_friend') }
      let(:new_online_application) { build(:online_application, legal_representative: 'legal_representative') }

      context 'and the legal_representative changed' do
        it 'clears national insurance questions' do
          expect(storage).to have_received(:clear_form).with(:legal_representative_detail)
        end
      end
    end
  end
end
