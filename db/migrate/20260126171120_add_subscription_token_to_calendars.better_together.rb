# frozen_string_literal: true

# This migration comes from better_together (originally 20260123235504)
# Migration to add subscription_token column to calendars table
# Enables calendar feed subscriptions with unique, secure tokens
class AddSubscriptionTokenToCalendars < ActiveRecord::Migration[7.2]
  def change
    add_column :better_together_calendars, :subscription_token, :string
    add_index :better_together_calendars, :subscription_token, unique: true
  end
end
