require 'rails_helper'

RSpec.describe Forms::LegalRepresentativeDetail do
  subject(:form) { described_class.new(params) }

  let(:params) {
    {
      legal_representative_first_name: 'John',
      legal_representative_last_name: 'Lawyer',
      legal_representative_organisation_name: 'Law and Co',
      legal_representative_email: 'law@co.com',
      street: 'Treadlneedl',
      postcode: 'N103EE',
      town: 'London'
    }
  }

  describe 'validation' do
    let(:params) { {} }
    let(:error_messages) { form.errors.messages }

    before do
      form.valid?
    end

    it { expect(error_messages[:legal_representative_first_name].first).to eq 'Please enter first name' }
    it { expect(error_messages[:legal_representative_last_name].first).to eq 'Please enter last name' }
    it { expect(error_messages[:street].first).to eq 'Enter your house number and street' }
    it { expect(error_messages[:postcode].first).to eq 'Enter your postcode' }
    it { expect(error_messages[:town].first).to eq 'Enter your town or city' }
  end

  describe 'sanitise email' do
    before do
      params.merge!(legal_representative_email: ' law@co.com ')
    end

    it 'remove blank spaces from email address' do
      expect(form.valid?).to be true
    end
  end

  describe 'do not sanitise blank email' do
    before do
      params.merge!(legal_representative_email: nil)
    end

    it 'remove blank spaces from email address' do
      expect(form.valid?).to be true
    end
  end
end
