# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.
require 'cucumber/rails'
require_relative './page_objects/base_page'
require 'capybara/apparition'
require 'capybara/cucumber'
require 'base64'
require 'webmock'
include WebMock::API

Dir[File.dirname(__FILE__) + '/page_objects/**/*.rb'].each { |f| require f }

ActionController::Base.allow_rescue = false

# #Define global variables
# ENV['zap_proxy'] = "localhost"
# ENV['zap_proxy_port'] = '8099'
ENV['HOSTNAME'] = 'localhost'

After do |scenario|
  Capybara.reset_sessions!
end


# #Below lines are our driver profile settings to reach internet through a proxy
# #You can set security=true as environment variable or declare it on command window
# if ENV['security'] == "true"
#   Capybara.register_driver :selenium do |app|
#     profile = Selenium::WebDriver::Firefox::Profile.new
#     profile["network.proxy.type"] = 1
#     profile["network.proxy.http"] = ENV['zap_proxy']
#     profile["network.proxy.http_port"] = ENV['zap_proxy_port']
#     Capybara::Selenium::Driver.new(app, :profile => profile)
#   end
# end

# ENV['NO_PROXY'] = ENV['no_proxy'] = '127.0.0.1'
# if ENV['APP_HOST']
#   Capybara.app_host = ENV['APP_HOST']
#   if Capybara.app_host.chars.last != '/'
#     Capybara.app_host += '/'
#   end
# end

# Capybara.raise_server_errors = false

# require 'capybara/cucumber'
# require 'base64'
# require 'date'

# Before('@cross-service') do
#   Capybara.always_include_port = false
#   Capybara.app_host = 'https://public.demo.hwf.dsd.io'
# end
