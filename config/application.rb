require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HwfPublicapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # OLD
    config.i18n.available_locales = %i[en cy]

    config.app_title = 'Help with fees - MoJ'
    config.proposition_title = 'Help with fees'
    config.product_type = 'service'

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W[#{config.root}/lib]

    # The following values are required by the phase banner
    config.phase = 'beta'
    config.feedback_url = 'https://docs.google.com/a/digital.justice.gov.uk/forms/d/14Y5aWnDO5J71QaStlVh3djwMZ3_sI_c0FQI6qsnj4P4/viewform?c=0&w=1'

    # prevent fields being enclosed in field_with_error divs
    config.action_view.field_error_proc = proc { |html_tag, _instance|
      html_tag
    }

  end
end
