# frozen_string_literal: true

module NewToNlHostDashboard
  extend ::ActiveSupport::Concern

  included do
    before_action :set_new_to_nl_dashboard_data, only: :index
  end

  def set_new_to_nl_dashboard_data
    new_to_nl_classes = [
      Partner, Resource, JourneyStage, Topic, JourneyMap
    ]

    new_to_nl_classes.each do |klass|
      # sets @klasses and @klass_count instance variables
      set_resource_variables(klass)
    end
  end
end
