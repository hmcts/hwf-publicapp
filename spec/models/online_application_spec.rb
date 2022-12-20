require 'rails_helper'

RSpec.describe OnlineApplication do
  describe '#full_name' do
    subject { model.full_name }

    let(:model) { build(:online_application, title: title) }

    context 'when title is set' do
      let(:title) { 'Title' }

      it 'contains title, first name and last name' do
        expect(subject).to eql("#{title} #{model.first_name} #{model.last_name}")
      end
    end

    context 'when title is not set' do
      let(:title) { nil }

      it 'contains only first name and last name' do
        expect(subject).to eql("#{model.first_name} #{model.last_name}")
      end
    end
  end

  describe '#savings_and_investment_extra_required?' do
    subject { model.savings_and_investment_extra_required? }

    let(:model) { build(:online_application, min_threshold_exceeded: min_threshold_exceeded, max_threshold_exceeded: max_threshold_exceeded) }

    context 'when minimum threshold has not been exceeded' do
      let(:min_threshold_exceeded) { false }
      let(:max_threshold_exceeded) { nil }

      it { is_expected.to be false }
    end

    context 'when maximum threshold has been exceeded' do
      let(:min_threshold_exceeded) { true }
      let(:max_threshold_exceeded) { true }

      it { is_expected.to be false }
    end

    context 'when minimum threshold has been exceeded, but maximum threshold has not been exceeded' do
      let(:min_threshold_exceeded) { true }
      let(:max_threshold_exceeded) { false }

      it { is_expected.to be true }
    end
  end
end
