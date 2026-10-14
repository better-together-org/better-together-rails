# frozen_string_literal: true

# Sentry carries errors. Traces and profiles belong to OpenTelemetry (Tempo)
# and Pyroscope, so sampling here stays low to protect the span quota.
# A traces_sampler overrides traces_sample_rate, so sampling is decided here only.
SENTRY_UNSAMPLED_PATHS = %r{\A/(healthcheck|up|assets|cable|rails/active_storage|packs)(/|\z)}

Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN', '')
  config.release = ENV.fetch('GIT_REV', '')

  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  traces_rate = ENV.fetch('SENTRY_TRACES_SAMPLE_RATE', '0.05').to_f
  config.traces_sampler = lambda do |context|
    parent = context[:parent_sampled]
    next parent unless parent.nil?

    path = (context[:rack_env] || {}).fetch('PATH_INFO', '').to_s
    path.match?(SENTRY_UNSAMPLED_PATHS) ? 0.0 : traces_rate
  end
  config.profiles_sample_rate = ENV.fetch('SENTRY_PROFILES_SAMPLE_RATE', '0').to_f
end
