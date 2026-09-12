# frozen_string_literal: true

require 'socket'

# rubocop:disable Metrics/BlockLength
Rails.application.config.after_initialize do
  observability_app = ENV.fetch('BTS_OBSERVABILITY_APP', ENV.fetch('DOKKU_APP_NAME', 'communityengine'))
  service_name = ENV.fetch('BETTER_TOGETHER_OBSERVABILITY_SERVICE_NAME', 'communityengine.app')
  host_name = ENV.fetch('HOSTNAME', Socket.gethostname)
  trace_context_from_runtime = lambda do
    return {} unless defined?(OpenTelemetry::Trace)

    span = OpenTelemetry::Trace.current_span
    return {} unless span.respond_to?(:context)

    span_context = span.context
    return {} unless span_context.respond_to?(:valid?) && span_context.valid?

    {
      trace_id: span_context.hex_trace_id,
      span_id: span_context.hex_span_id
    }
  rescue StandardError
    {}
  end

  BetterTogether.register_error_reporter(:bts_local) do |exception, context:|
    normalized_context = context.to_h.with_indifferent_access
    trace_context = trace_context_from_runtime.call

    payload = {
      event_type: 'ce.exception',
      severity: 'error',
      handled: true,
      service_name: service_name,
      app: observability_app,
      environment: Rails.env,
      host: host_name,
      request_id: normalized_context[:request_id],
      trace_id: normalized_context[:trace_id],
      span_id: normalized_context[:span_id],
      controller: normalized_context[:controller],
      action: normalized_context[:action],
      path: normalized_context[:path],
      status: normalized_context[:status],
      platform_id: normalized_context[:platform_id],
      community_id: normalized_context[:community_id],
      person_id: normalized_context[:person_id],
      user_id: normalized_context[:user_id],
      request_method: normalized_context[:request_method],
      exception_class: exception.class.name,
      exception_message: exception.message.to_s.gsub(/\s+/, ' ')[0, 500]
    }.merge(trace_context).compact

    Rails.logger.error(payload.to_json)
  end

  next unless defined?(Sentry) && ENV['SENTRY_DSN'].present?

  BetterTogether.register_error_reporter(:sentry) do |exception, context:|
    Sentry.with_scope do |scope|
      scope.set_tags(
        app: observability_app,
        service_name: service_name,
        environment: Rails.env
      )
      scope.set_context('better_together', context.to_h.transform_keys(&:to_s))
      Sentry.capture_exception(exception)
    end
  end
end
# rubocop:enable Metrics/BlockLength
