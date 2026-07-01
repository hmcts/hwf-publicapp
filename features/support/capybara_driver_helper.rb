require 'capybara/cuprite'

Selenium::WebDriver.logger.level = :error

# Smoke/e2e runs drive a deployed app over CAPYBARA_APP_HOST (no in-process
# server), so they need a real browser. Everything else runs in-process and
# defaults to the rack_test driver - it has no browser and is much faster than
# driving Firefox/Chrome. Scenarios that genuinely need a browser (native
# <details> rendering, JS-revealed fields, etc.) are tagged @javascript and run
# under cuprite headless Chrome instead (see Capybara.javascript_driver).
remote_app_host = ENV.key?('CAPYBARA_APP_HOST') &&
                  ENV['CAPYBARA_APP_HOST'].to_s.exclude?('localhost')

Capybara.configure do |config|
  config.default_driver =
    if ENV['DRIVER']
      ENV['DRIVER'].to_sym
    elsif remote_app_host
      :firefox
    else
      :rack_test
    end
  config.default_max_wait_time = 10
  config.default_normalize_ws = true
  config.match = :prefer_exact
  config.exact = true
  config.visible_text_only = true
end

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(app, headless: true, window_size: [1280, 800],
                                     process_timeout: 30, timeout: 15,
                                     slow_mo: ENV.fetch('CUPRITE_SLOW_MO', 0).to_f,
                                     browser_options: { 'no-sandbox': nil, 'disable-dev-shm-usage': nil })
end

Capybara.register_driver :firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.args << '--headless'
  options.args << '--disable-gpu'
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end
Capybara.register_driver :headless do |app|
  chrome_options = Selenium::WebDriver::Chrome::Options.new(args: %w[--headless=new --disable-gpu --no-sandbox --disable-dev-shm-usage --disable-search-engine-choice-screen])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
end

Capybara.register_driver :apparition do |app|
  Capybara::Apparition::Driver.new(app, js_errors: false)
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :firefox_zap do |app|
  proxy = Selenium::WebDriver::Proxy.new(
    http: 'localhost:8080',
    ssl: 'localhost:8080'
  )
  options = Selenium::WebDriver::Firefox::Options.new
  options.args << '--headless'
  options.args << '--disable-gpu'
  options.proxy = proxy
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end

playwright_options = {
  headless: true,
  playwright_cli_executable_path: './node_modules/.bin/playwright'
}

Capybara.register_driver(:playwright_chrome) do |app|
  Capybara::Playwright::Driver.new(app, browser_type: :chromium, channel: 'chrome', **playwright_options)
end

Capybara.register_driver(:playwright_msedge) do |app|
  Capybara::Playwright::Driver.new(app, browser_type: :chromium, channel: 'msedge', **playwright_options)
end

Capybara.register_driver(:playwright_firefox) do |app|
  Capybara::Playwright::Driver.new(app, browser_type: :firefox, **playwright_options)
end

Capybara.register_driver(:playwright_webkit) do |app|
  Capybara::Playwright::Driver.new(app, browser_type: :webkit, **playwright_options)
end

if ENV.key?('CIRCLE_ARTIFACTS')
  Capybara.save_and_open_page_path = ENV['CIRCLE_ARTIFACTS']
end

Capybara.always_include_port = true
Capybara.javascript_driver = ENV.fetch('CAPYBARA_JAVASCRIPT_DRIVER', 'cuprite').to_sym
Capybara.app_host = ENV.fetch('CAPYBARA_APP_HOST', "http://#{ENV.fetch('HOSTNAME', 'localhost')}")
Capybara.server_host = ENV.fetch('CAPYBARA_SERVER_HOST', ENV.fetch('HOSTNAME', 'localhost'))
Capybara.server_port = ENV.fetch('CAPYBARA_SERVER_PORT', '3000') unless
  ENV['CAPYBARA_SERVER_PORT'] == 'random'
