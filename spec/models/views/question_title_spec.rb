require 'rails_helper'

RSpec.describe Views::QuestionTitle do
  subject(:service) { described_class.new(form, online_application) }

  describe '#i18n_title' do
    subject { service.i18n_title }

    let(:form) { instance_double(Forms::Benefit, id: id) }
    let(:online_application) { build(:online_application) }

    context 'for the benefit question' do
      let(:id) { 'benefit' }

      context 'when the online_application says it is a refund' do
        let(:online_application) { build(:online_application, :refund) }

        it { is_expected.to eql('text_refund') }
      end

      context 'when the online_application says it is not a refund' do
        let(:online_application) { build(:online_application) }

        it { is_expected.to eql('text') }
      end
    end

    context 'for the savings_and_investment_extra question' do
      let(:id) { 'savings_and_investment_extra' }

      context 'when the online_application says the user is married' do
        let(:online_application) { build(:online_application, married: true) }

        it { is_expected.to eql('text_married') }
      end

      context 'when the online_application says the user is single' do
        let(:online_application) { build(:online_application, married: false) }

        it { is_expected.to eql('text_single') }
      end
    end

    %w[income_kind income_range income_amount].each do |question|
      context "for the #{question} question" do
        let(:id) { question }

        context 'when the online_application says the user is married' do
          context 'when the online_application says it is a refund' do
            let(:online_application) { build(:online_application, :refund, married: true) }

            it { is_expected.to eql('text_married_refund') }
          end

          context 'when the online_application says it is not a refund' do
            let(:online_application) { build(:online_application, married: true) }

            it { is_expected.to eql('text_married') }
          end
        end

        context 'when the online_application says the user is single' do
          context 'when the online_application says it is a refund' do
            let(:online_application) { build(:online_application, :refund, married: false) }

            it { is_expected.to eql('text_single_refund') }
          end

          context 'when the online_application says it is not a refund' do
            let(:online_application) { build(:online_application, married: false) }

            it { is_expected.to eql('text_single') }
          end
        end
      end
    end

    context 'for other questions' do
      let(:id) { 'probate' }

      it { is_expected.to eql('text') }
    end
  end
end
