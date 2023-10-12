require 'webmock/cucumber'
require_relative 'capybara_driver_helper'
URI.parse ENV.fetch('SELENIUM_URL', 'http://localhost:4444/wd/hub')
URI.parse Capybara.app_host
# WebMock.disable_net_connect!(allow_localhost: true, allow: [selenium_url.host, app_host_url.host, 'ondemand.saucelabs.com', 'chromedriver.storage.googleapis.com'])
WebMock.allow_net_connect!
