RSpec.describe ProbateFeesSwitch do
  subject { described_class }

  describe '#disable_probate_fees?' do
    subject do
      travel_to(current_time) do
        described_class.disable_probate_fees?
      end
    end

    context 'when called after the set date' do
      let(:current_time) { probate_fees_release_date }

      it { is_expected.to be true }
    end

    context 'when called before the set date' do
      let(:current_time) { a_day_before_disable_probate_fees }

      it { is_expected.to be false }
    end
  end
end
