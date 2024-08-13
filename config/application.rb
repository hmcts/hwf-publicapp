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

module HwfPublicapp
  class Application < Rails::Application

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

    # The following values are required by the phase banner
    config.phase = 'beta'
    config.feedback_url = 'https://www.smartsurvey.co.uk/s/HWFFeed20/'

    # When the application is finished
    config.finish_page_redirect_url = 'https://www.smartsurvey.co.uk/s/HWFExit20/'

    config.x.address_lookup.endpoint = ENV.fetch('ADDRESS_LOOKUP_ENDPOINT', nil)
    config.x.address_lookup.api_key = ENV.fetch('ADDRESS_LOOKUP_API_KEY', nil)
    config.x.address_lookup.api_secret = ENV.fetch('ADDRESS_LOOKUP_API_SECRET', nil)

    config.maintenance_enabled = ENV.fetch('MAINTENANCE_ENABLED', 'false').casecmp('true').zero?
    config.maintenance_allowed_ips = ENV.fetch('MAINTENANCE_ALLOWED_IPS', '').split(',').map(&:strip)
    config.maintenance_end = ENV.fetch('MAINTENANCE_END', nil)

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Custom directory with validators
    config.autoload_paths += Dir["#{config.root}/app/validators"]

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.action_view.field_error_proc = proc do |html_tag, _instance|
      html_tag
    end
  end
end
