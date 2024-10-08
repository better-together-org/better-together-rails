# frozen_string_literal: true

# This migration comes from better_together (originally 20240901173825)
# This migration comes from noticed (originally 20240129184740)
class AddNotificationsCountToNoticedEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :noticed_events, :notifications_count, :integer
  end
end
