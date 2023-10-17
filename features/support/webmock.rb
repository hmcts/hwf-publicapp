require 'webmock/cucumber'
# rubocop:disable Style/MixinUsage
include WebMock::API
# rubocop:enable Style/MixinUsage

require_relative 'capybara_driver_helper'

selenium_url = URI.parse ENV.fetch('SELENIUM_URL', 'http://localhost:4444/wd/hub')
app_host_url = URI.parse Capybara.app_host

stub_request(:post, "https://api.os.uk/oauth2/token/v1").
  with(
    body: { "grant_type" => "client_credentials" },
    headers: {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => 'Basic YXBpX2tleTphcGlfc2VjcmV0',
      'Content-Type' => 'application/x-www-form-urlencoded',
      'User-Agent' => 'Ruby'
    }
  )

stub_request(:get, "https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build.json").
  with(
    headers: {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Host' => 'googlechromelabs.github.io',
      'User-Agent' => 'Ruby'
    }
  ).
  to_return(status: 200, body: {}.to_json, headers: {})

WebMock.disable_net_connect!(allow_localhost: true, allow: [selenium_url.host, app_host_url.host, 'ondemand.saucelabs.com', 'chromedriver.storage.googleapis.com', 'https://messages.cucumber.io/api/reports'])
