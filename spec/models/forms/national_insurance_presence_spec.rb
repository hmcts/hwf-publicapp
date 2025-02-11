RSpec.describe Forms::NationalInsurancePresence do
  subject(:form_nip) { described_class.new }

  describe 'validation' do
    context 'when ni_number_present is empty' do
      before { form_nip.ni_number_present = nil }

      it { expect(form_nip.valid?).to be false }
    end

    context 'when ni_number_present is true' do
      before { form_nip.ni_number_present = true }

      it { expect(form_nip.valid?).to be true }
    end

    context 'when ni_number_present is false' do
      before { form_nip.ni_number_present = false }

      it { expect(form_nip.valid?).to be true }
    end
  end

  describe '#export' do
    subject { described_class.new(ni_number_present: ni_number_present).export }

    let(:ni_number_present) { true }

    it 'returns hash with ho_number set' do
      expect(subject).to eql(ni_number_present: ni_number_present)
    end
  end

end
