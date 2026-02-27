# frozen_string_literal: true

# This migration comes from better_together (originally 20260227002623)
# Adds community_id foreign key to better_together_webhook_endpoints,
# enabling community-scoped webhook endpoints managed by community admins.
class AddCommunityToWebhookEndpoints < ActiveRecord::Migration[7.2]
  def change
    add_reference :better_together_webhook_endpoints, :community,
                  type: :uuid,
                  null: true,
                  foreign_key: { to_table: :better_together_communities },
                  index: true
  end
end
