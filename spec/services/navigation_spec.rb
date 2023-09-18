require 'rails_helper'

RSpec.describe Navigation do
  include Rails.application.routes.url_helpers

  let(:online_application) { build(:online_application) }

  before { travel_to a_day_before_disable_probate_fees }
  after { travel_back }

  describe '#next' do
    subject { described_class.new(online_application, current_question).next }

    {
      fee: :form_name,
      form_name: :national_insurance_presence,
      national_insurance_presence: :national_insurance,
      national_insurance: :marital_status,
      home_office: :marital_status,
      marital_status: :savings_and_investment,
      savings_and_investment_extra: :benefit,
      dependent: :income_kind,
      income_amount: :probate,
      probate: :claim,
      claim: :dob,
      dob: :personal_detail,
      personal_detail: :applicant_address,
      applicant_address: :contact,
      contact: :apply_type
    }.each do |current_question, next_question|
      context "for #{current_question} question" do
        let(:current_question) { current_question }

        it "routes to #{next_question} question" do
          expect(subject).to eql(question_path(next_question, locale: :en))
        end
      end
    end

    context 'for benefit question' do
      let(:online_application) { build(:online_application, benefits: benefits, form_name: form_name) }
      let(:current_question) { :benefit }
      let(:form_name) { nil }

      context 'when the application is benefit one' do
        let(:benefits) { true }

        it 'routes to the probate question (skips dependent and income)' do
          expect(subject).to eql(question_path(:probate, locale: :en))
        end

        context 'probate switch is active' do
          let(:a_day_after_disable_probate_fees) { probate_fees_release_date + 1.day }

          before { travel_to a_day_after_disable_probate_fees }

          it 'does not routes to the probate question' do
            expect(subject).not_to eql(question_path(:probate, locale: :en))
          end
        end
      end

      context 'when the application is not a benefit one' do
        let(:benefits) { false }

        it 'routes to the dependent question' do
          expect(subject).to eql(question_path(:dependent, locale: :en))
        end
      end
    end

    context 'for savings and investment question' do
      let(:current_question) { :savings_and_investment }

      context 'when the extra question is required' do
        let(:online_application) { build(:online_application, :extra_savings_question_required) }

        it 'routes to the extra question' do
          expect(subject).to eql(question_path(:savings_and_investment_extra, locale: :en))
        end
      end

      context 'when the extra question is not required' do
        let(:online_application) { build(:online_application, ho_number: nil) }

        it 'routes to the benefit question' do
          expect(subject).to eql(question_path(:benefit, locale: :en))
        end
      end
    end

    context 'for contact question' do
      let(:current_question) { :contact }

      it 'routes to the summary page' do
        expect(subject).to eql(question_path(:apply_type, locale: :en))
      end
    end

    context 'for contact question when refund' do
      let(:online_application) { build(:online_application, :refund) }
      let(:current_question) { :contact }

      it 'routes to the summary page' do
        expect(subject).to eql(summary_path(locale: :en))
      end
    end

    context 'for apply_type question' do
      let(:current_question) { :apply_type }

      it 'routes to the summary page' do
        expect(subject).to eql(summary_path(locale: :en))
      end
    end

    context 'for income_kind question' do
      let(:current_question) { :income_kind }

      context 'when the application is 0 income - "no income" selected' do
        let(:online_application) { build(:online_application, :no_income) }

        it 'routes to the probate question' do
          expect(subject).to eql(question_path(:probate, locale: :en))
        end
      end

      context 'when the application is not 0 income - some income sources selected' do
        it 'routes to the income_range question' do
          expect(subject).to eql(question_path(:income_range, locale: :en))
        end
      end
    end

    context 'for income_range question' do
      let(:current_question) { :income_range }

      context 'when the application is between thresholds' do
        let(:online_application) { build(:online_application, :income_between_thresholds) }

        it 'routes to the income_amount question' do
          expect(subject).to eql(question_path(:income_amount, locale: :en))
        end
      end

      context 'when the application is below thresholds' do
        let(:online_application) { build(:online_application, :income_below_thresholds) }

        it 'routes to the probate question' do
          expect(subject).to eql(question_path(:probate, locale: :en))
        end
      end

      context 'when the application is above thresholds' do
        let(:online_application) { build(:online_application, :income_above_thresholds) }

        it 'routes to the probate question' do
          expect(subject).to eql(question_path(:probate, locale: :en))
        end
      end
    end

    context 'when the NI number is not present' do
      let(:current_question) { :national_insurance_presence }
      let(:online_application) { build(:online_application, ni_number_present: false) }

      it 'routes to the home office question' do
        expect(subject).to eql(question_path(:home_office, locale: :en))
      end
    end

    context 'when the NI number is present and page is NI number page' do
      let(:current_question) { :national_insurance }
      let(:online_application) { build(:online_application, ni_number_present: true) }

      it 'routes to the marital_status question' do
        expect(subject).to eql(question_path(:marital_status, locale: :en))
      end
    end

    context 'when the NI number is present and current page is home office' do
      let(:current_question) { :home_office }
      let(:online_application) { build(:online_application) }

      it 'routes to the marital_status question' do
        expect(subject).to eql(question_path(:marital_status, locale: :en))
      end
    end

    context 'when the home office number is present' do
      let(:online_application) { build(:online_application, ho_number: 'L1234567') }
      let(:current_question) { :savings_and_investment_extra }

      it 'skips the benefit question' do
        expect(subject).to eql(question_path(:dependent, locale: :en))
      end
    end

  end
end
