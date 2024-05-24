require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BetterTogether
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.api_only = false
    config.session_store :cookie_store, key: '_bt_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Use middleware to handle forwarded headers
    # config.middleware.use Rack::Protection::HttpOrigin, origin_whitelist: [ENV.fetch('APP_HOST') { 'http://localhost:3000' }]

    I18n.enforce_available_locales = true

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

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
      :address        => ENV.fetch('SMTP_ADDRESS') { 'smtp.sendgrid.net' },
      :port           => '587',
      :authentication => :plain,
      :user_name      => ENV.fetch('SMTP_USERNAME') { 'apikey' },
      :password       => ENV['SMTP_PASSWORD'],
      :domain         => ENV.fetch('APP_HOST') { 'localhost:3000'},
      :enable_starttls_auto => true
    }

    Rails.application.routes.default_url_options = {
      host: ENV.fetch('APP_HOST', 'http://localhost:3000')
    }

    config.action_mailer.default_url_options = {
      host: ENV.fetch('APP_HOST', 'http://localhost:3000')
    }

    config.time_zone = 'Newfoundland'
  end
end
