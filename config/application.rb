# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'better_together/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BetterTogether
  class Application < Rails::Application # rubocop:todo Style/Documentation
    # Initialize configuration defaults for originally generated Rails version.
    config.api_only = false
    config.session_store :cookie_store, key: '_bt_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.test_framework :rspec
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.eager_load_paths << Rails.root.join("extras")

    # Use middleware to handle forwarded headers
    # rubocop:todo Layout/LineLength
    # config.middleware.use Rack::Protection::HttpOrigin, origin_whitelist: [ENV.fetch('APP_HOST') { 'http://localhost:3000' }]
    # rubocop:enable Layout/LineLength

    I18n.enforce_available_locales = true

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    config.active_storage.analyzers = [
      ActiveStorage::Analyzer::ImageAnalyzer::Vips,
      ActiveStorage::Analyzer::ImageAnalyzer::ImageMagick,
      ActiveStorage::Analyzer::VideoAnalyzer,
      ActiveStorage::Analyzer::AudioAnalyzer
    ]

    config.action_mailer.default_options = {
      from: ENV.fetch('FROM_ADDRESS', 'Better Together Community <community@bettertogethersolutions.com>'),
      reply_to: ENV.fetch('REPLY_ADDRESS', 'Better Together Community Support <support@bettertogethersolutions.com>')
    }

    config.action_mailer.smtp_settings = {
      address: ENV.fetch('SMTP_ADDRESS', 'smtp.sendgrid.net'),
      port: '587',
      authentication: :plain,
      user_name: ENV.fetch('SMTP_USERNAME', 'apikey'),
      password: ENV.fetch('SMTP_PASSWORD', nil),
      domain: ENV.fetch('APP_HOST', 'localhost:3000'),
      enable_starttls_auto: true
    }

    default_url_options = {
      **::BetterTogether::Engine.routes.default_url_options
    }

    Rails.application.routes.default_url_options =
      config.action_mailer.default_url_options =
        config.default_url_options =
          default_url_options

    config.time_zone = ENV.fetch('APP_TIME_ZONE', 'Newfoundland')

    # Accepts inbound mail relayed from the BTS mail-receiver via the built-in
    # Rails relay ingress controller (POST /rails/action_mailbox/relay/inbound_emails,
    # HTTP Basic Auth, username "actionmailbox"). Password comes from ENV per the
    # BTS secrets convention rather than Rails encrypted credentials.
    config.action_mailbox.ingress = :relay

    # CE engine's own better_together.configure_active_job initializer force-sets
    # queue_adapter = :sidekiq. config/environments/test.rb's plain assignment to
    # :test gets clobbered because engine initializers run after environment
    # config loads, and a config.after_initialize override isn't late enough
    # either: in CI (config.eager_load = ENV['CI'].present?), eager loading
    # resolves ActiveJob::Base's queue_adapter for keeps before after_initialize
    # callbacks run. An ordered initializer in the same group, scheduled right
    # after the engine's, wins outright regardless of eager_load timing.
    initializer 'better_together_rails.force_test_queue_adapter',
                after: 'better_together.configure_active_job' do |app|
      app.config.active_job.queue_adapter = :test if Rails.env.test?
    end

    # Add engine manifest to precompile assets in production
    initializer 'assets' do |app|
      # Ensure we are not modifying frozen arrays
      app.config.assets.precompile += %w[manifest.js]
      app.config.assets.paths = [root.join('app', 'assets', 'images'),
                                 root.join('app', 'javascript')] + app.config.assets.paths.to_a
    end
  end
end
