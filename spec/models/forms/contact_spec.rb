require 'rails_helper'

RSpec.describe Forms::Contact do
  subject(:form) { described_class.new(email: email, feedback_opt_in: feedback_opt_in) }

  let(:email) { 'some@email.domain' }
  let(:feedback_opt_in) { false }

  describe 'validations' do
    describe 'email' do
      context 'when valid email is given' do
        context 'when the email is more than 99 characters' do
          let(:email) { "#{'A' * 90}@domain.co" }

          it { is_expected.not_to be_valid }
        end

        context 'when the email is maximum 99 characters' do
          let(:email) { "#{'A' * 89}@domain.co" }

          it { is_expected.to be_valid }
        end
      end

      context 'when invalid email is given' do
        let(:email) { 'foobar.com' }

        it { is_expected.not_to be_valid }
      end

      context 'when email is empty string' do
        let(:email) { '' }

        it { is_expected.to be_valid }
      end

      context 'when email is nil' do
        let(:email) { nil }

        it { is_expected.to be_valid }
      end
    end

    describe 'feedback_opt_in' do
      context 'when true' do
        it { is_expected.to be_valid }
      end

      context 'when false' do
        let(:feedback_opt_in) { false }

        it { is_expected.to be_valid }
      end
    end

    describe 'email and feedback_opt_in' do
      context 'when feedback_opt_in is true' do
        let(:feedback_opt_in) { true }

        context 'when email is nil' do
          let(:email) { nil }

          it { is_expected.not_to be_valid }
        end

        context 'when email is empty string' do
          let(:email) { '' }

          it { is_expected.not_to be_valid }
        end
      end

      context 'when 'do

      end
    end
  end

  describe '#export' do
    subject { form.export }

    context 'when email is set' do
      let(:email) { '  some@email.domain  ' }
      let(:trimmed_email) { 'some@email.domain' }

      it 'the returned hash includes email_contact true and email_address' do
        expect(subject).to include(email_contact: true, email_address: trimmed_email)
      end
    end

    context 'when email is not set' do
      let(:email) { nil }

      it 'the returned hash includes email_contact false and email_address is nil' do
        expect(subject).to include(email_contact: false, email_address: email)
      end
    end

    it 'the returned hash always returns phone_contact as false' do
      expect(subject).to include(phone_contact: false)
    end

    it 'the returned hash includesreturns post_contact as false' do
      expect(subject).to include(post_contact: false)
    end

    context 'when feedback_opt_in is true' do
      let(:feedback_opt_in) { true }

      it 'the returned hash includes feedback_opt_in true' do
        expect(subject).to include(feedback_opt_in: true)
      end
    end

    context 'when feedback_opt_in is false' do
      let(:feedback_opt_in) { false }

      it 'the returned hash includes feedback_opt_in false' do
        expect(subject).to include(feedback_opt_in: false)
      end
    end
  end

end
