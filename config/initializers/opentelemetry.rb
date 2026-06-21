# frozen_string_literal: true

require 'socket'

begin
  enabled = ActiveModel::Type::Boolean.new.cast(ENV.fetch('BETTER_TOGETHER_OTEL_ENABLED', nil))

  if enabled
    endpoint = ENV.fetch('OTEL_EXPORTER_OTLP_ENDPOINT', nil).presence

    unless endpoint
      Rails.logger.warn(
        '[Observability] BETTER_TOGETHER_OTEL_ENABLED=true but ' \
        'OTEL_EXPORTER_OTLP_ENDPOINT is not set; skipping OpenTelemetry init'
      )
    end

    if endpoint
      require 'opentelemetry/sdk'
      require 'opentelemetry/exporter/otlp'
      require 'opentelemetry/instrumentation/rails'
      require 'opentelemetry/instrumentation/sidekiq'

      ENV['OTEL_TRACES_EXPORTER'] ||= 'otlp'
      ENV['OTEL_EXPORTER_OTLP_ENDPOINT'] = endpoint
      ENV['OTEL_EXPORTER_OTLP_PROTOCOL'] ||= 'http/protobuf'
      ENV['OTEL_PROPAGATORS'] ||= 'tracecontext,baggage'

      default_service_name = ENV.fetch(
        'BETTER_TOGETHER_OBSERVABILITY_SERVICE_NAME',
        'communityengine.app'
      )
      service_name = ENV.fetch('OTEL_SERVICE_NAME', default_service_name).to_s
      service_version = ENV.fetch('OTEL_SERVICE_VERSION', ENV.fetch('GIT_REV', 'dev')).to_s
      observability_app = ENV.fetch('BTS_OBSERVABILITY_APP', ENV.fetch('DOKKU_APP_NAME', 'communityengine')).to_s
      host_name = ENV.fetch('HOSTNAME', Socket.gethostname).to_s
      environment_name = Rails.env.to_s

      resource = OpenTelemetry::SDK::Resources::Resource.create(
        'deployment.environment' => environment_name,
        'host.name' => host_name,
        'service.namespace' => 'better_together',
        'service.name' => service_name,
        'service.version' => service_version,
        'bts.app' => observability_app
      )

      OpenTelemetry::SDK.configure do |c|
        c.resource = resource
        c.use 'OpenTelemetry::Instrumentation::Rails'
        c.use 'OpenTelemetry::Instrumentation::Sidekiq'
      end

      # The Rack instrumentation Railtie registers its middleware-insertion
      # initializer during SDK.configure, but Rails won't pick up Railtie
      # initializers added mid-run. Insert the middleware explicitly so HTTP
      # request spans reach Tempo.
      rack_inst = OpenTelemetry::Instrumentation::Rack::Instrumentation.instance
      Rails.application.middleware.insert_before(
        ActionDispatch::RequestId,
        *rack_inst.middleware_args
      )

      Rails.logger.info("[Observability] OpenTelemetry tracing enabled for #{service_name} -> #{endpoint}")
    end
  end
rescue StandardError => e
  Rails.logger.error("[Observability] OpenTelemetry init failed #{e.class}: #{e.message}")
end
