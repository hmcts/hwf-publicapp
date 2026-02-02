module Forms
  module Cookie
    class SettingForm < Base
      COOKIE_NAME = 'cookie_setting'.freeze
      COOKIES_VALUES = { yes: true, no: false }.freeze

      attribute :cookie_setting, :string
      attr_accessor :response, :request

      def self.choices
        [
          COOKIES_VALUES[:yes],
          COOKIES_VALUES[:no]
        ].map(&:to_s)
      end

      validates :cookie_setting, inclusion: { in: choices }

      def cookie_setting
        super.presence || cookie_setting_value
      end

      def accepted?
        cookie_setting.to_s == COOKIES_VALUES[:yes].to_s
      end

      def preference_set?
        self.class.choices.include?(request.cookies[COOKIE_NAME])
      end

      def i18n_scope
        'home.cookies'
      end

      def save
        if cookie_setting.present?
          persist!
        end
      end

      private

      def cookie_setting_value
        if request.present?
          request.cookies[COOKIE_NAME] || COOKIES_VALUES[:no]
        else
          COOKIES_VALUES[:no]
        end
      end

      def persist!
        response.delete_cookie(COOKIE_NAME, {})

        response.set_cookie(
          COOKIE_NAME,
          value: cookie_setting,
          expires: 1.year.from_now
        )
        true
      end
    end
  end
end
