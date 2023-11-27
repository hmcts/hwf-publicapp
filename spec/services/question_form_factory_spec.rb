require 'rails_helper'

RSpec.describe QuestionFormFactory do
  describe '.position' do
    subject { described_class.position(id) }

    let(:id) { :benefit }

    it 'returns the position of the given question' do
      expect(subject).to eq 8
    end
  end

  describe '.get_form' do
    subject(:get_form) { described_class.get_form(id) }

    context 'claim question' do
      let(:id) { :claim }

      context 'when the online_application is not an ET one' do
        it { is_expected.to be_a(Forms::Claim::Default) }
      end
    end

    context 'probate question' do
      let(:id) { :probate }

      context 'when the online_application is not an ET one' do
        it { is_expected.to be_a(Forms::Probate) }
      end
    end

    context 'for other existing question' do
      let(:id) { :marital_status }

      it 'returns an instance of the form' do
        expect(subject).to be_a(Forms::MaritalStatus)
      end
    end

    context 'for a question that does not exist' do
      let(:id) { :wrong }

      it 'raises QuestionDoesNotExist error' do
        expect { get_form }.to raise_error(QuestionFormFactory::QuestionDoesNotExist)
      end
    end
  end
end
