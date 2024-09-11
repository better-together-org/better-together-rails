# frozen_string_literal: true

# This migration comes from better_together (originally 20240831140605)
# Adds a jsonb column to platforms to allow for dynmaic and flexible storage and retrieval of settings
class AddSettingsToBetterTogetherPlatforms < ActiveRecord::Migration[7.1]
  def change
    add_column :better_together_platforms, :settings, :jsonb, null: false, default: {}
  end
end
