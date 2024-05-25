# frozen_string_literal: true

class ApplicationController < ::BetterTogether::ApplicationController # rubocop:todo Style/Documentation
  protected

  def error_reporting(exception)
    # Send exception to Sentry
    Sentry.capture_exception(exception)
  end
end
