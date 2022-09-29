source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'azure_env_secrets', github: 'ministryofjustice/azure_env_secrets', tag: 'v0.1.3'
gem 'dotenv-rails', groups: %i[development test] # this has to be here because of load order
gem 'rails', '~> 7.0.3'

gem 'application_insights', '~> 0.5.6'
gem 'bootsnap', require: false
gem 'config'
gem 'date_validator'
gem 'jquery-rails'
gem 'nokogiri'
gem 'puma', '~> 5.6.4'
gem 'rest-client'
gem 'sass-rails'
gem 'sentry-raven'
gem 'slim-rails'
gem 'uglifier'
gem 'virtus'


group :development, :test do
  gem "debug", ">= 1.0.0"
  gem 'rubocop', '~> 1.15', require: false
  gem 'rubocop-rails'
  gem 'letter_opener'
end

group :development do
  gem 'foreman'
  gem 'launchy'
  gem 'listen'
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'apparition'
  gem 'brakeman'
  gem 'capybara'
  gem 'regexp_parser'
  gem 'capybara-screenshot'
  gem 'codeclimate-test-reporter'
  gem 'cucumber-rails', require: false
  gem 'factory_bot_rails'
  gem 'parallel_tests'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'rubocop-rspec', '~> 2.3', require: false
  gem 'rubyzip'
  gem 'shoulda-matchers'
  gem 'site_prism'
  gem 'timecop'
  gem 'webdrivers'
  gem 'webmock'
end
