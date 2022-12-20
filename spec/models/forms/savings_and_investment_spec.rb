require 'rails_helper'

RSpec.describe Forms::SavingsAndInvestment do
  subject(:form) { described_class.new(choice: choice) }

  describe '#export' do
    subject { form.export }

    context 'when choice is "less"' do
      let(:choice) { :less }

      it 'returns hash with min_threshold_exceeded parameter false' do
        expect(subject).to eql(min_threshold_exceeded: false)
      end
    end

    context 'when choice is "between"' do
      let(:choice) { :between }

      it 'returns hash with min_threshold_exceeded parameter true and max_threshold_exceeded parameter false' do
        expect(subject).to eql(min_threshold_exceeded: true, max_threshold_exceeded: false)
      end
    end

    context 'when choice is "more"' do
      let(:choice) { :more }

      it 'returns hash with min_threshold_exceeded parameter true and max_threshold_exceeded parameter true' do
        expect(subject).to eql(min_threshold_exceeded: true, max_threshold_exceeded: true)
      end
    end

    context 'when choice is not set' do
      let(:choice) { nil }

      it 'returns an empty hash' do
        expect(subject).to eql({})
      end
    end
  end
end
