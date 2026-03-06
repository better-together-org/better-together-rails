# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN', '')
  config.release = ENV.fetch('GIT_REV', '')

  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  config.traces_sample_rate = 0.1
  config.profiles_sample_rate = 0.1
end
