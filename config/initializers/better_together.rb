# frozen_string_literal: true

require 'better_together'

BetterTogether.base_url = ENV.fetch(
  'BASE_URL',
  'http://localhost:3000'
)
BetterTogether.user_class = '::BetterTogether::User'
BetterTogether.route_scope_path = ''

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Migration::Current.include BetterTogether::MigrationHelpers
  ActiveRecord::ConnectionAdapters::Table.include BetterTogether::ColumnDefinitions
  ActiveRecord::ConnectionAdapters::TableDefinition.include BetterTogether::ColumnDefinitions
end

Rails.application.config.to_prepare do
  require_dependency 'better_together/content/block'
  require_dependency 'better_together/navigation_item'
  require_dependency 'better_together/page'

  BetterTogether::Content::Block.include(NewToNlContentBlock)
  BetterTogether::NavigationItem.include(NewToNlNavigationItem)
  BetterTogether::Page.include(NewToNlJourneyStage)
  BetterTogether::Page.include(NewToNlTopic)
end
