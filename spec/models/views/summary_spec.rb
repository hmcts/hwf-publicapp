require 'rails_helper'

RSpec.describe Views::Summary do
  subject(:summary) { described_class.new(online_application) }

  let(:online_application) { build(:online_application) }

  %i[married benefits children income probate deceased_name date_of_death
     probate ni_number date_of_birth full_name email_contact email_address].each do |method|
    it "delegates #{method} to the online_application" do
      expect(summary.send(method)).to eql(online_application.send(method))
    end
  end

  describe 'income_validation_fails?' do
    subject { summary.income_validation_fails? }

    let(:online_application) { build(:online_application, income: income, benefits: benefits) }

    context 'when benefits are true' do
      let(:benefits) { true }

      context 'and income is nil' do
        let(:income) { nil }

        it { is_expected.to be false }
      end

      context 'and income is set' do
        let(:income) { 0 }

        it { is_expected.to be false }
      end
    end

    context 'when benefits are false' do
      let(:threshold_attributes) { { married: true, children: 3, benefits: benefits } }
      let(:benefits) { false }

      context 'when the income is below the thresholds' do
        let(:online_application) { build(:online_application, :income_below_thresholds, threshold_attributes) }

        it { is_expected.to be false }
      end

      context 'when the income is above the thresholds' do
        let(:online_application) { build(:online_application, :income_above_thresholds, threshold_attributes) }

        it { is_expected.to be false }
      end

      context 'when income is not set' do
        let(:online_application) { build(:online_application, :income_not_set, threshold_attributes) }

        it { is_expected.to be true }
      end

      context 'and income is set' do
        let(:income) { 0 }

        it { is_expected.to be false }
      end
    end
  end

  describe '#form_name' do
    subject { summary.form_name }

    let(:online_application) { build(:online_application, form_name: form_name) }

    context 'when the form_name is not nil' do
      let(:form_name) { 'SOME FORM NAME' }

      it { is_expected.to eql(form_name) }
    end

    context 'when the form_name is nil' do
      let(:form_name) { nil }

      it { is_expected.to eql('—') }
    end
  end

  describe '#savings' do
    subject { summary.savings }

    context 'when the minimum threshold has not been exceeded' do
      let(:online_application) { build(:online_application, :savings_less_than_threshold) }

      it 'returns the correct text - less than minimum threshold' do
        expect(subject).to eql('£0 to £2,999')
      end
    end

    context 'when the minimum threshold has been exceeded but not the maximum threshold' do
      context 'when the applicant or partner are over 66' do
        let(:online_application) { build(:online_application, :savings_between_threshold, over_66: true) }

        it 'returns the correct text - between thresholds' do
          expect(subject).to eql('£3,000 to £15,999')
        end
      end

      context 'when the applicant or partner are not over 66' do
        let(:online_application) { build(:online_application, :savings_between_threshold, over_66: false, amount: 6000) }

        it 'returns the correct text - exact amount' do
          expect(subject).to eql('£6,000')
        end
      end
    end

    context 'when the maximum threshold has been exceeded' do
      let(:online_application) { build(:online_application, :savings_more_than_threshold) }

      it 'returns the correct text - more than maximum threshold' do
        expect(subject).to eql('£16,000 or more')
      end
    end
  end

  describe '#income_text' do
    subject { summary.income_text }

    let(:threshold_attributes) { { married: true, children: 3 } }

    context 'when the income is between the thresholds' do
      let(:online_application) { build(:online_application, :income_between_thresholds, income: 1600) }

      it 'returns the exact income amount formatted as a currency' do
        expect(subject).to eql('£1,600')
      end
    end

    context 'when the income is below the thresholds' do
      let(:online_application) { build(:online_application, :income_below_thresholds, threshold_attributes) }

      it 'returns copy saying the applicant earns less than the calculated threshold' do
        expect(subject).to eql('Less than £2,140')
      end
    end

    context 'when the income is above the thresholds' do
      let(:online_application) { build(:online_application, :income_above_thresholds, threshold_attributes) }

      it 'returns copy saying the applicant earns more than the calculated threshold' do
        expect(subject).to eql('More than £6,140')
      end
    end

    context 'when income is not set' do
      let(:online_application) { build(:online_application, :income_not_set, threshold_attributes) }

      it { is_expected.to be_nil }
    end
  end

  describe '#refund_text' do
    subject { summary.refund_text }

    context 'when refund is true' do
      let(:online_application) { build(:online_application, refund: true, date_fee_paid: '01/02/2016') }

      it 'returns Yes with date paid' do
        expect(subject).to eql('Yes, on 01/02/2016')
      end
    end

    context 'when refund is false' do
      it { is_expected.to eql('No') }
    end
  end

  describe '#children_text' do
    subject { summary.children_text }

    context 'when children is 0' do
      it { is_expected.to eql('No') }
    end

    context 'when children is greater than 0' do
      let(:online_application) { build(:online_application, children: 3) }

      it 'returns the number of children' do
        expect(subject).to eql('3')
      end
    end
  end

  describe '#case_number?' do
    subject { summary.case_number? }

    context 'when case_number is set' do
      let(:online_application) { build(:online_application, case_number: 'BBB') }

      it { is_expected.to be true }
    end

    context 'when case_number is not set' do
      it { is_expected.to be false }
    end
  end

  describe '#full_address' do
    let(:online_application) { build(:online_application, street: 'Street', town: 'City', postcode: 'POSTCODE') }

    it 'returns address and postcode with space between' do
      expect(summary.full_address).to eql('Street City POSTCODE')
    end
  end

  describe '#signed_by_representative applicant' do
    let(:online_application) { build(:online_application, applying_on_behalf: nil) }

    it { expect(summary.signed_by_representative).to be false }
  end

  describe '#signed_by_representative litigation friend' do
    let(:online_application) { build(:online_application, applying_on_behalf: true, legal_representative: 'litigation_friend') }

    it { expect(summary.signed_by_representative).to be false }
  end

  describe '#signed_by_representative legal representative' do
    let(:online_application) { build(:online_application, applying_on_behalf: true, legal_representative: 'legal_representative') }

    it { expect(summary.signed_by_representative).to be true }
  end

  describe '#display_benefits?' do
    let(:online_application) { build(:online_application, over_16: over_16, ho_number: '') }

    context "is over 16" do
      let(:over_16) { true }

      it { expect(summary.display_benefits?).to be true }
    end

    context "is under 16" do
      let(:over_16) { false }

      it { expect(summary.display_benefits?).to be false }
    end

    context "over 16 is nil" do
      let(:over_16) { nil }

      it { expect(summary.display_benefits?).to be true }
    end
  end

  describe '#display_ni?' do
    let(:online_application) { build(:online_application, over_16: over_16) }

    context "is over 16" do
      let(:over_16) { true }

      it { expect(summary.display_ni?).to be true }
    end

    context "is under 16" do
      let(:over_16) { false }

      it { expect(summary.display_ni?).to be false }
    end

    context "over 16 is nil" do
      let(:over_16) { nil }

      it { expect(summary.display_ni?).to be true }
    end
  end
end
