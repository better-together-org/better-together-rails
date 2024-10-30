# frozen_string_literal: true

Rails.application.config.to_prepare do
  require_dependency 'better_together/host_dashboard_controller'

  BetterTogether::HostDashboardController.include(NewToNlHostDashboard)
end
