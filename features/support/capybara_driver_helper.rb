Selenium::WebDriver.logger.level = :error

Capybara.configure do |config|
  driver = ENV['DRIVER']&.to_sym || :firefox
  config.default_driver = driver
  config.default_max_wait_time = 10
  config.default_normalize_ws = true
  config.match = :prefer_exact
  config.exact = true
  config.visible_text_only = true
end

Capybara.register_driver :firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.args << '--headless'
  options.args << '--disable-gpu'
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end
Capybara.register_driver :headless do |app|
  chrome_options = Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
end

Capybara.register_driver :apparition do |app|
  Capybara::Apparition::Driver.new(app, js_errors: false)
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

if ENV.key?('CIRCLE_ARTIFACTS')
  Capybara.save_and_open_page_path = ENV['CIRCLE_ARTIFACTS']
end

Capybara.always_include_port = true
Capybara.javascript_driver = Capybara.default_driver
Capybara.app_host = ENV.fetch('CAPYBARA_APP_HOST', "http://#{ENV.fetch('HOSTNAME', 'localhost')}")
Capybara.server_host = ENV.fetch('CAPYBARA_SERVER_HOST', ENV.fetch('HOSTNAME', 'localhost'))
Capybara.server_port = ENV.fetch('CAPYBARA_SERVER_PORT', '3000') unless
  ENV['CAPYBARA_SERVER_PORT'] == 'random'
