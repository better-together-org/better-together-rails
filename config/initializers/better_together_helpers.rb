# frozen_string_literal: true

# config/initializers/better_together_helpers.rb

Rails.application.config.to_prepare do
  # Define the path to the host application's helpers
  helper_files = Dir[Rails.root.join('app', 'helpers', '**', '*_helper.rb')]

  helper_files.each do |file|
    # Convert file path to module name
    # Example: "app/helpers/application_helper.rb" => "ApplicationHelper"
    relative_path = file.sub("#{Rails.root}/app/helpers/", '').sub('.rb', '')
    module_name = relative_path.camelize

    begin
      # Constantize the module name to get the actual module
      helper_module = module_name.constantize

      # Include the helper module into the engine's ApplicationController
      BetterTogether::ApplicationController.helper(helper_module)

      # Log successful inclusion (optional)
      Rails.logger.info "Included helper module #{module_name} into BetterTogether::ApplicationController"
    rescue NameError => e
      # Log a warning if the module cannot be constantized
      Rails.logger.warn "Unable to include helper module #{module_name}: #{e.message}"
    end
  end
end
