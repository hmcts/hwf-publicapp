# frozen_string_literal: true
require 'rails_helper'

module Forms
  RSpec.describe BaseRange, type: :model do
    subject(:form) { described_class.new(choice: choice) }

    describe 'validations' do
      describe 'choice' do
        context 'when "less"' do
          let(:choice) { 'less' }

          it { is_expected.to be_valid }
        end

        context 'when "between"' do
          let(:choice) { 'between' }

          it { is_expected.to be_valid }
        end

        context 'when "more"' do
          let(:choice) { 'more' }

          it { is_expected.to be_valid }
        end

        context 'when neither "less, between or more"' do
          let(:choice) { 'whatever' }

          it { is_expected.to be_invalid }
        end

        context 'when empty' do
          let(:choice) { nil }

          it { is_expected.to be_invalid }
        end
      end
    end

  end
end
