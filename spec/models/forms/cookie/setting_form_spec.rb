require 'rails_helper'

RSpec.describe Forms::Cookie::SettingForm do
  subject { described_class.new(cookie_setting: value, request: request, response: response) }

  let(:value) { 'true' }
  let(:request) { nil }
  let(:response) { nil }

  before do
    Timecop.freeze(Time.zone.local(1990))
  end

  after do
    Timecop.return
  end

  describe '.choices' do
    it 'returns the relevant choices' do
      expect(described_class.choices).to eq(%w[true false])
    end
  end

  describe '.cookie_setting' do
    context 'when no value was set and no request cookie present' do
      let(:value) { nil }
      let(:request) { nil }

      it 'returns default value "no"' do
        expect(subject.cookie_setting).to eq(Forms::Cookie::SettingForm::COOKIES_VALUES[:no])
      end
    end

    context 'when no value was set and cookie present' do
      let(:value) { nil }
      let(:request) { instance_double(ActionDispatch::Request, cookies: { Forms::Cookie::SettingForm::COOKIE_NAME => 'true' }) }

      it 'returns value hold in cookie' do
        expect(subject.cookie_setting).to eq('true')
      end
    end

    it 'returns set value when present' do
      expect(subject.cookie_setting).to eq(value)
    end
  end

  describe '.accepted?' do
    context 'when cookie_setting is "yes"' do
      let(:value) { 'true' }

      it 'returns true' do
        expect(subject).to be_accepted
      end
    end

    context 'when cookie_setting is "no"' do
      let(:value) { 'false' }

      it 'returns false' do
        expect(subject).not_to be_accepted
      end
    end
  end

  describe '.preference_set?' do
    context 'when cookie set to NO' do
      let(:cookie_value_no) { Forms::Cookie::SettingForm::COOKIES_VALUES[:no].to_s }
      let(:request) { instance_double(ActionDispatch::Request, cookies: { Forms::Cookie::SettingForm::COOKIE_NAME => cookie_value_no }) }

      specify { expect(subject).to be_preference_set }
    end

    context 'when cookie set to YES' do
      let(:cookie_value_yes) { Forms::Cookie::SettingForm::COOKIES_VALUES[:yes].to_s }
      let(:request) { instance_double(ActionDispatch::Request, cookies: { Forms::Cookie::SettingForm::COOKIE_NAME => cookie_value_yes }) }

      specify { expect(subject).to be_preference_set }
    end

    context 'when cookie has wrong value' do
      let(:request) { instance_double(ActionDispatch::Request, cookies: { Forms::Cookie::SettingForm::COOKIE_NAME => '' }) }

      specify { expect(subject).not_to be_preference_set }
    end

    context 'when cookie missing' do
      let(:request) { instance_double(ActionDispatch::Request, cookies: {}) }

      specify { expect(subject).not_to be_preference_set }
    end
  end

  describe '#save' do
    let(:response) { instance_double(ActionDispatch::Response) }

    before do
      allow(response).to receive(:delete_cookie).with(Forms::Cookie::SettingForm::COOKIE_NAME, {})
      allow(response).to receive(:set_cookie)
    end

    it 'save cookie preference' do
      expect(subject.save).to be true
    end

    it 'set value and expire time' do
      subject.save
      expect(response).to have_received(:set_cookie).with(
        Forms::Cookie::SettingForm::COOKIE_NAME,
        value: value,
        expires: 1.year.from_now
      )
    end

    it 'delete previos settings' do
      subject.save
      expect(response).to have_received(:delete_cookie).with(Forms::Cookie::SettingForm::COOKIE_NAME, {})
    end
  end
end
