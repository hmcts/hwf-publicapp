require 'rails_helper'

RSpec.describe OnlineApplicationBuilder do
  subject(:builder) { described_class.new(storage) }

  let(:session) do
    {
      'questions' =>
      {
        'marital_status' => { 'married' => true },
        'savings_and_investment' => { 'choice' => 'between' },
        'savings_and_investment_extra' => { 'over_61' => false, 'amount' => 6000 },
        'benefit' => { 'on_benefits' => true },
        'dependent' => { 'children' => true, 'children_number' => 2 },
        'fee' => { 'paid' => true, 'day_date_paid' => '12', 'month_date_paid' => '12', 'year_date_paid' => '2015' },
        'income_amount' => { 'amount' => 550 },
        'probate' => { 'kase' => true, 'deceased_name' => 'Mr. Deceased', 'day_date_of_death' => '01', 'month_date_of_death' => '08', 'year_date_of_death' => '2015' },
        'claim/default' => { 'number' => true, 'identifier' => 'CL001' },
        'form_name' => { 'identifier' => 'EX47' },
        'national_insurance' => { 'number' => 'AA123456A' },
        'personal_detail' => { 'title' => 'Mrs.', 'first_name' => 'Mary', 'last_name' => 'Jones' },
        'dob' => { 'day' => '10', 'month' => '03', 'year' => '1967' },
        'applicant_address' => { 'street' => '1 Blue Fields', 'town' => 'Shine Town', 'postcode' => 'SH01 TW0' },
        'contact' => { 'email' => 'mary@jones.com', 'feedback_opt_in' => true }
      }
    }
  end
  # We're using the real storage here to avoid an unnecessary mocking as these are mostly value objects
  let(:storage) { Storage.new(session) }

  describe '#online_application' do
    subject(:online_application) { builder.online_application }

    it 'returns an online_application' do
      expect(subject).to be_a(OnlineApplication)
    end

    it 'assigns the correct values to each field' do
      expect(online_application.married).to be true
      expect(online_application.min_threshold_exceeded).to be true
      expect(online_application.max_threshold_exceeded).to be false
      expect(online_application.over_61).to be false
      expect(online_application.amount).to eq 6000
      expect(online_application.benefits).to be true
      expect(online_application.children).to eq 2
      expect(online_application.income).to eq 550
      expect(online_application.refund).to be true
      expect(online_application.date_fee_paid).to eql(Date.parse('12/12/2015'))
      expect(online_application.probate).to be true
      expect(online_application.deceased_name).to eql('Mr. Deceased')
      expect(online_application.date_of_death).to eql(Date.parse('01/08/2015'))
      expect(online_application.case_number).to eql('CL001')
      expect(online_application.form_name).to eql('EX47')
      expect(online_application.ni_number).to eql('AA123456A')
      expect(online_application.date_of_birth).to eql(Date.parse('10/03/1967'))
      expect(online_application.title).to eql('Mrs.')
      expect(online_application.first_name).to eql('Mary')
      expect(online_application.last_name).to eql('Jones')
      expect(online_application.street).to eql('1 Blue Fields')
      expect(online_application.town).to eql('Shine Town')
      expect(online_application.postcode).to eql('SH01 TW0')
      expect(online_application.email_contact).to be true
      expect(online_application.email_address).to eql('mary@jones.com')
      expect(online_application.phone_contact).to be false
      expect(online_application.post_contact).to be false
      expect(online_application.feedback_opt_in).to be true
    end
  end
end
