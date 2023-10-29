require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BetterTogether
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    # prevent `rails generate` from creating assets when scaffolding
    config.generators do |g|
      g.assets false
    end

    config.eager_load_paths += %W[#{config.root}/app/helpers]

    config.active_job.queue_adapter = :sidekiq
    config.sidekiq = config_for(:sidekiq)

    config.action_mailer.smtp_settings = {
      address: 'smtp.sendgrid.net',
      port: '587',
      authentication: :plain,
      user_name: ENV.fetch('SENDGRID_USERNAME', ''),
      password: ENV.fetch('SENDGRID_PASSWORD', ''),
      domain: 'heroku.com',
      enable_starttls_auto: true
    }

    Rails.application.routes.default_url_options = {
      host: ENV.fetch('APP_HOST', 'http://localhost:3000')
    }

    config.action_mailer.default_url_options = {
      host: ENV.fetch('APP_HOST', 'http://localhost:3000')
    }
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
