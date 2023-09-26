require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

ENV['RAILS_DISABLE_DEPRECATED_TO_S_CONVERSION'] = "true"

module HwfPublicapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    #### Rails 6.1
    config.i18n.available_locales = %i[en cy]

    if ENV['AZURE_APP_INSIGHTS_INSTRUMENTATION_KEY'].present?
      config.middleware.use(
        ApplicationInsights::Rack::TrackRequest,
        ENV['AZURE_APP_INSIGHTS_INSTRUMENTATION_KEY']
      )
    end

    config.app_title = 'Help with fees - MoJ'
    config.proposition_title = 'Help with fees'
    config.product_type = 'service'

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W[#{config.root}/lib]

    # Custom directory with validators
    config.autoload_paths += Dir["#{config.root}/app/validators"]

    # The following values are required by the phase banner
    config.phase = 'beta'
    config.feedback_url = 'https://www.smartsurvey.co.uk/s/HWFFeed20/'

    # When the application is finished
    config.finish_page_redirect_url = 'https://www.smartsurvey.co.uk/s/HWFExit20/'

    # prevent fields being enclosed in field_with_error divs
    config.action_view.field_error_proc = proc { |html_tag, _instance|
      html_tag
    }

    config.x.address_lookup.endpoint = ENV.fetch('ADDRESS_LOOKUP_ENDPOINT', nil)
    config.x.address_lookup.api_key = ENV.fetch('ADDRESS_LOOKUP_API_KEY', nil)
    config.x.address_lookup.api_secret = ENV.fetch('ADDRESS_LOOKUP_API_SECRET', nil)

    config.maintenance_enabled = ENV.fetch('MAINTENANCE_ENABLED', 'false').casecmp('true').zero?
    config.maintenance_allowed_ips = ENV.fetch('MAINTENANCE_ALLOWED_IPS', '').split(',').map(&:strip)
    config.maintenance_end = ENV.fetch('MAINTENANCE_END', nil)

    ####
  end
end
