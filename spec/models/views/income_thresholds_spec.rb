require 'rails_helper'

RSpec.describe Views::IncomeThresholds do
  subject(:service) { described_class.new(online_application) }

  let(:online_application) { build(:online_application, married: married, children: children) }

  describe '#min_threshold' do
    subject { service.min_threshold }

    context 'when the applicant is single without kids' do
      let(:married) { false }
      let(:children) { 0 }

      it 'calculates the right minimum threshold' do
        expect(subject).to eq 1085
      end
    end

    context 'when the applicant is single with kids' do
      let(:married) { false }
      let(:children) { 2 }

      it 'calculates the right minimum threshold' do
        expect(subject).to eq 1575
      end
    end

    context 'when the applicant is married without kids' do
      let(:married) { true }
      let(:children) { 0 }

      it 'calculates the right minimum threshold' do
        expect(subject).to eq 1245
      end
    end

    context 'when the applicant is married with kids' do
      let(:married) { true }
      let(:children) { 2 }

      it 'calculates the right minimum threshold' do
        expect(subject).to eq 1735
      end
    end
  end

  describe '#max_threshold' do
    subject { service.max_threshold }

    context 'when the applicant is single without kids' do
      let(:married) { false }
      let(:children) { 0 }

      it 'calculates the right minimum threshold' do
        expect(subject).to eq 5085
      end
    end

    context 'when the applicant is single with kids' do
      let(:married) { false }
      let(:children) { 2 }

      it 'calculates the right minimum threshold' do
        expect(subject).to eq 5575
      end
    end

    context 'when the applicant is married without kids' do
      let(:married) { true }
      let(:children) { 0 }

      it 'calculates the right minimum threshold' do
        expect(subject).to eq 5245
      end
    end

    context 'when the applicant is married with kids' do
      let(:married) { true }
      let(:children) { 2 }

      it 'calculates the right minimum threshold' do
        expect(subject).to eq 5735
      end
    end
  end
end
