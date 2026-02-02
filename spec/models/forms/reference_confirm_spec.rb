require 'rails_helper'

RSpec.describe Forms::ReferenceConfirm do
  subject(:form) { described_class.new(reference_confirm: reference_confirm) }

  let(:reference_confirm) { true }

  describe 'validations' do
    context 'when true' do
      it { is_expected.to be_valid }
    end

    context 'when false' do
      let(:reference_confirm) { false }

      it { is_expected.not_to be_valid }
    end

    context 'when nil' do
      let(:reference_confirm) { nil }

      it { is_expected.not_to be_valid }
    end
  end
end
