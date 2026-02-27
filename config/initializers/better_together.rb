# frozen_string_literal: true

require 'better_together'

BetterTogether.base_url = ENV.fetch(
  'BASE_URL',
  'http://localhost:3000'
)
BetterTogether.user_class = '::BetterTogether::User'
BetterTogether.route_scope_path = ''

# Host app API v1 route extensions.
# Add jsonapi_resources calls for app-specific models here.
# Example (for newcomer-navigator-nl or nl-venues):
#   BetterTogether.api_v1_routes_extension = proc do
#     jsonapi_resources :wayfinders
#   end

# Additional swagger UI endpoints (app-specific OpenAPI docs).
# Example:
#   BetterTogether.swagger_additional_endpoints << ['/api/docs/v1/my-app-swagger.yaml', 'My App API V1']

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Migration::Current.include BetterTogether::MigrationHelpers
  ActiveRecord::ConnectionAdapters::Table.include BetterTogether::ColumnDefinitions
  ActiveRecord::ConnectionAdapters::TableDefinition.include BetterTogether::ColumnDefinitions
end
