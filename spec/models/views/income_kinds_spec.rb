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
        let(:applicant) { [1, 8, 13] }

        it 'returns list of translated kinds without "no income"' do
          expect(subject).to eql(['Wages before tax and National Insurance are taken off', 'Contribution-based Employment and Support Allowance (ESA)', 'Cash gifts'])
        end
      end

      context 'when they do not contain "no income"' do
        let(:applicant) { [1, 8] }

        it 'returns list of translated kinds' do
          expect(subject).to eql(['Wages before tax and National Insurance are taken off', 'Contribution-based Employment and Support Allowance (ESA)'])
        end
      end
    end

    context 'when applicant and partner kinds are present' do
      let(:income_kind) { { 'applicant' => applicant, 'partner' => partner } }

      context 'when they contain "no income" and others' do
        let(:applicant) { [1, 8, 13] }
        let(:partner) { [1, 5, 13] }

        it 'returns list of merged translated kinds without "no income"' do
          expect(subject).to eql(['Wages before tax and National Insurance are taken off',
                                  'Child Tax Credit', 'Contribution-based Employment and Support Allowance (ESA)', 'Cash gifts'])
        end
      end

      context 'when they do not contain "no income"' do
        let(:applicant) { [1, 8] }
        let(:partner) { [1, 5] }

        it 'returns list of merged translated kinds' do
          expect(subject).to eql(['Wages before tax and National Insurance are taken off',
                                  'Child Tax Credit', 'Contribution-based Employment and Support Allowance (ESA)'])
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
