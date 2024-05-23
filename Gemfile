source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '3.3.1'

gem 'azure_env_secrets', github: 'hmcts/azure_env_secrets', tag: 'v1.0.1'
gem 'dotenv-rails', groups: %i[development test] # this has to be here because of load order
gem 'rails', '7.1.3.3'

gem 'application_insights', '~> 0.5.6'
gem 'bootsnap', require: false
gem 'config'
gem 'date_validator'
gem "dartsass-sprockets", "~> 3.1"
gem 'jquery-rails'
gem 'nokogiri'
gem 'puma'
gem 'rack', '~> 3.0.8'
gem 'redis'
gem 'rest-client'
gem 'sentry-rails'
gem 'slim-rails'
gem 'uglifier'
gem 'virtus'
gem 'govuk_notify_rails'

group :development, :test do
  gem "pry-rails"
  gem 'letter_opener'
  gem 'rubocop', '~> 1.40', require: false
  gem 'rubocop-rails'
  gem 'rubocop-performance', require: false
  gem 'simplecov', '~> 0.21'
  gem 'parallel_tests'
  gem 'bundler-audit'
end

group :development do
  gem 'launchy'
  gem 'listen'
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'apparition'
  gem 'brakeman'
  gem 'capybara'
  gem 'codeclimate-test-reporter'
  gem 'cucumber-rails', require: false
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'regexp_parser'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'rubocop-rspec', '~> 2.16', require: false
  gem 'rubyzip'
  gem 'selenium-webdriver', '~> 4.14'
  gem 'shoulda-matchers'
  gem 'site_prism'
  gem "test-prof", "~> 1.1"
  gem 'timecop'
  gem 'webmock'
end
