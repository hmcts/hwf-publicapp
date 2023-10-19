require 'webmock/cucumber'
# rubocop:disable Style/MixinUsage
include WebMock::API
# rubocop:enable Style/MixinUsage

require_relative 'capybara_driver_helper'

URI.parse ENV.fetch('SELENIUM_URL', 'http://localhost:4444/wd/hub')
URI.parse Capybara.app_host

# WebMock.disable_net_connect!(allow_localhost: true, allow: [selenium_url.host, app_host_url.host, 'https://messages.cucumber.io/api/reports'])
WebMock.allow_net_connect!
