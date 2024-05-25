class ApplicationController < ::BetterTogether::ApplicationController
  protected

  def error_reporting(exception)
    # Send exception to Sentry
    Sentry.capture_exception(exception)
  end
end
