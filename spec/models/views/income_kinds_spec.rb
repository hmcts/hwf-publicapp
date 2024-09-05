require 'rails_helper'

RSpec.describe Views::IncomeKinds do
  subject(:view) { described_class.new(session) }

  let(:rails_store) { Rails.cache }

  describe '#list' do
    subject { view.list }

    let(:session) { instance_double(ActionDispatch::Request::Session, id: id) }
    let(:id) { rand(9999999) }

    before do
      rails_store.write("questions-#{session.id}-income_kind", income_kind)
    end

    context 'when only applicant kinds are present' do

      let(:income_kind) { { 'applicant' => applicant } }

      context 'when they contain "no income" and others' do
        let(:applicant) { [:wage, :universal_credit, :none_of_the_above] }

        it 'returns list of translated kinds without "no income"' do
          expect(subject).to eql(['Wages before tax and National Insurance are taken off', 'Universal Credit'])
        end
      end

      context 'when they do not contain "no income"' do
        let(:applicant) { [:wage, :universal_credit] }

        it 'returns list of translated kinds' do
          expect(subject).to eql(['Wages before tax and National Insurance are taken off', 'Universal Credit'])
        end
      end
    end

    context 'when applicant and partner kinds are present' do
      let(:income_kind) { { 'applicant' => applicant, 'partner' => partner } }

      context 'when they contain "no income" and others' do
        let(:applicant) { [:wage, :universal_credit, :none_of_the_above] }
        let(:partner) { [:wage, :maintenance_payments, :none_of_the_above] }

        it 'returns list of merged translated kinds without "no income"' do
          expect(subject).to eql(['Wages before tax and National Insurance are taken off', 'Universal Credit',
                                  'Maintenance payments'])
        end
      end

      context 'when they do not contain "no income"' do
        let(:applicant) { [:wage, :universal_credit] }
        let(:partner) { [:wage, :maintenance_payments] }

        it 'returns list of merged translated kinds' do
          expect(subject).to eql(['Wages before tax and National Insurance are taken off', 'Universal Credit',
                                  'Maintenance payments'])
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
