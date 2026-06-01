# frozen_string_literal: true

require 'socket'

# rubocop:disable Metrics/BlockLength
Rails.application.config.after_initialize do
  enabled = ActiveModel::Type::Boolean.new.cast(ENV.fetch('BETTER_TOGETHER_PYROSCOPE_ENABLED', nil))
  next unless enabled

  server_address = ENV.fetch('BETTER_TOGETHER_PYROSCOPE_SERVER_ADDRESS', nil).presence
  unless server_address
    Rails.logger.warn(
      '[Observability] BETTER_TOGETHER_PYROSCOPE_ENABLED=true but ' \
      'BETTER_TOGETHER_PYROSCOPE_SERVER_ADDRESS is not set; skipping Pyroscope init'
    )
    next
  end

  require 'pyroscope'

  service_name = ENV.fetch('BETTER_TOGETHER_OBSERVABILITY_SERVICE_NAME', 'communityengine.app')
  observability_app = ENV.fetch('BTS_OBSERVABILITY_APP', ENV.fetch('DOKKU_APP_NAME', 'communityengine'))
  host_name = ENV.fetch('HOSTNAME', Socket.gethostname)
  role_name = ENV.fetch('BETTER_TOGETHER_PYROSCOPE_ROLE', 'web')

  Pyroscope.configure do |config|
    config.application_name = service_name
    config.server_address = server_address
    config.autoinstrument_rails = true
    config.report_pid = true
    config.report_thread_id = true
    config.tags = {
      'app' => observability_app,
      'environment' => Rails.env,
      'host' => host_name,
      'role' => role_name
    }
  end

  Rails.logger.info("[Observability] Pyroscope profiling enabled for #{service_name} -> #{server_address}")
rescue StandardError => e
  Rails.logger.error("[Observability] Pyroscope init failed #{e.class}: #{e.message}")
end
# rubocop:enable Metrics/BlockLength
