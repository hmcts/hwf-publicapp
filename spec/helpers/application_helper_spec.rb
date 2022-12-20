RSpec.describe ApplicationHelper do
  describe 'cookies_accepted?' do
    context 'when accepted analytics cookies' do
      before do
        setting_form = instance_double(Forms::Cookie::SettingForm)
        allow(Forms::Cookie::SettingForm).to receive(:new).and_return setting_form
        allow(setting_form).to receive(:accepted?).and_return(true)
      end

      it { expect(helper).to be_cookies_accepted }
    end

    context 'when rejected analytics cookies' do
      it { expect(helper).not_to be_cookies_accepted }
    end
  end
end
