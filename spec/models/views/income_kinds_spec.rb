require 'rails_helper'

RSpec.describe Views::IncomeKinds do
  subject(:view) { described_class.new(session) }

  describe '#list' do
    subject { view.list }

    let(:session) { { 'questions' => { 'income_kind' => income_kind } } }

    context 'when only applicant kinds are present' do
      let(:income_kind) { { 'applicant' => applicant } }

      context 'when they contain "no income" and others' do
        let(:applicant) { [1, 8, 13] }

        it 'returns list of translated kinds without "no income"' do
          expect(subject).to eql(['Wages', 'Universal Credit'])
        end
      end

      context 'when they do not contain "no income"' do
        let(:applicant) { [1, 8] }

        it 'returns list of translated kinds' do
          expect(subject).to eql(['Wages', 'Universal Credit'])
        end
      end
    end

    context 'when applicant and partner kinds are present' do
      let(:income_kind) { { 'applicant' => applicant, 'partner' => partner } }

      context 'when they contain "no income" and others' do
        let(:applicant) { [1, 8, 13] }
        let(:partner) { [1, 5, 13] }

        it 'returns list of merged translated kinds without "no income"' do
          expect(subject).to eql(['Wages', 'Maintenance payments', 'Universal Credit'])
        end
      end

      context 'when they do not contain "no income"' do
        let(:applicant) { [1, 8] }
        let(:partner) { [1, 5] }

        it 'returns list of merged translated kinds' do
          expect(subject).to eql(['Wages', 'Maintenance payments', 'Universal Credit'])
        end
      end
    end

    context 'when no kinds are present' do
      let(:income_kind) { {} }

      it 'returns an empty array' do
        expect(subject).to be_empty
      end
    end
  end
end
