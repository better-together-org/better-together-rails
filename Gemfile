# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.4'

gem 'asset_sync'
gem 'aws-sdk-s3', require: false

# Use the published version of better_together for production
gem 'better_together', '~> 0.8',
    github: 'better-together-org/community-engine-rails',
    branch: 'main'

# Use the local development version of better_together
# gem 'better_together', path: '/community-engine'

# bcrypt for secure password handling
gem 'bcrypt', '~> 3.1.20'
# Bootsnap for faster boot times
gem 'bootsnap', '>= 1.7.0', require: false

gem 'fog-aws'

# Database adapter for PostgreSQL
gem 'pg', '>= 0.18', '< 2.0'
# Puma as the app server
gem 'puma', '~> 6.6'

# Pundit for authorization, custom fork for Better Together
gem 'pundit-resources', '~> 1.1.4', github: 'better-together-org/pundit-resources'

# Core Rails gem
gem 'rack-protection'
gem 'rails', '~> 7.1.5'

# Redis for ActionCable and background jobs
gem 'redis', '~> 5.4'
# Sidekiq for background processing

gem 'sidekiq', '~> 8.0.6'

# Error and performance monitoring with Sentry
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'stackprof'

# Storext for easier json attributes, custom fork for Better Together
gem 'storext', github: 'better-together-org/storext'

# Uglifier for JavaScript compression
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  # Better errors for enhanced error pages
  gem 'better_errors'
  # Binding of caller provides pry console at breakpoints
  gem 'binding_of_caller'
  # Debugger tool
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Faker for generating fake data
  gem 'faker'
  # FactoryBot for setting up test data
  gem 'factory_bot_rails'
  # Fuubar for fancy test progress bar
  gem 'fuubar'
  # Pry for a powerful shell alternative to IRB
  gem 'pry'
  # RuboCop for static code analysis
  gem 'rubocop'
end

group :development do
  # Brakeman for static analysis security vulnerability scanning
  gem 'brakeman', require: false
  # Bundler audit for checking gem vulnerabilities
  gem 'bundler-audit', require: false
  # Facilitate I18n translation management
  gem 'i18n_generators'
  # Help with managing translation databasde
  gem 'i18n-tasks', '~> 1.0.15'
  # Listen for file system changes
  gem 'listen', '>= 3.0.5', '< 3.10'
  # Rack mini profiler for performance profiling
  gem 'rack-mini-profiler'
  # Readline implementation for Ruby
  gem 'rb-readline'
  # Spring for fast Rails actions via pre-loading
  gem 'spring'
  # Spring watcher for file changes
  gem 'spring-watcher-listen', '~> 2.1.0'
  # Tracing tool
  gem 'rbtrace'
  # Web-console for an interactive console on exception pages
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Capybara for integration testing
  gem 'capybara', '>= 2.15'
  # Coveralls for test coverage reporting
  gem 'coveralls'
  # Database cleaner for test database cleaning
  gem 'database_cleaner'
  # # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'webdrivers'
  # RuboCop RSpec for RSpec-specific code analysis
  gem 'rubocop-rspec'
  # RSpec for unit testing
  gem 'rspec'
  # RSpec Rails integration
  gem 'rspec-rails'
  # Selenium WebDriver for browser automation
  gem 'selenium-webdriver'
  # Shoulda Callback Matchers for testing callbacks
  gem 'shoulda-callback-matchers'
  # Shoulda Matchers for simplifying model tests
  gem 'shoulda-matchers'
  # SimpleCov for test coverage analysis
  gem 'simplecov', require: false
end
