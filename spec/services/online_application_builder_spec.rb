require 'rails_helper'

RSpec.describe OnlineApplicationBuilder do
  subject(:builder) { described_class.new(storage) }

  let(:session_id) { 2 }
  let(:store_data) do
    rails_store = Rails.cache
    rails_store.write("questions-#{session_id}-over16", { 'married' => false, 'over_16' => false }.as_json)
    rails_store.write("questions-#{session_id}-savings_and_investment", { 'choice' => 'between' }.as_json)
    rails_store.write("questions-#{session_id}-savings_and_investment_extra", { 'over_61' => false, 'amount' => 6000 }.as_json)
    rails_store.write("questions-#{session_id}-benefit", { 'on_benefits' => true }.as_json)
    rails_store.write("questions-#{session_id}-dependent", { 'children' => true, 'children_number' => 2 }.as_json)
    rails_store.write("questions-#{session_id}-fee", { 'paid' => true, 'day_date_paid' => '12', 'month_date_paid' => '12', 'year_date_paid' => '2015' }.as_json)
    rails_store.write("questions-#{session_id}-income_period", { 'amount' => 550 }.as_json)
    rails_store.write("questions-#{session_id}-probate", { 'kase' => true, 'deceased_name' => 'Mr. Deceased', 'day_date_of_death' => '01', 'month_date_of_death' => '08', 'year_date_of_death' => '2015' }.as_json)
    rails_store.write("questions-#{session_id}-claim/default", { 'number' => true, 'identifier' => 'CL001' }.as_json)
    rails_store.write("questions-#{session_id}-form_name", { 'identifier' => 'EX47' }.as_json)
    rails_store.write("questions-#{session_id}-national_insurance", { 'number' => 'AA123456A' }.as_json)
    rails_store.write("questions-#{session_id}-personal_detail", { 'title' => 'Mrs.', 'first_name' => 'Mary', 'last_name' => 'Jones' }.as_json)
    rails_store.write("questions-#{session_id}-dob", { 'day' => '10', 'month' => '03', 'year' => '1967' }.as_json)
    rails_store.write("questions-#{session_id}-applicant_address", { 'street' => '1 Blue Fields', 'town' => 'Shine Town', 'postcode' => 'SH01 TW0' }.as_json)
    rails_store.write("questions-#{session_id}-contact", { 'email' => 'mary@jones.com', 'feedback_opt_in' => true }.as_json)
  end

  let(:storage) { Storage.new(session) }
  let(:session) { instance_double(ActionDispatch::Request::Session, id: session_id) }

  describe '#online_application' do
    subject(:online_application) { builder.online_application }

    before do
      store_data
      allow(session).to receive(:[]).with(:calculation_scheme).and_return FeatureSwitch::CALCULATION_SCHEMAS[1].to_s
      allow(session).to receive(:[]).with(:started_at).and_return ''
      allow(session).to receive(:[]=)
    end

    it 'returns an online_application' do
      expect(subject).to be_a(OnlineApplication)
    end

    it 'assigns the correct values to each field' do
      expect(online_application.over_16).to be false
      expect(online_application.married).to be false
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
