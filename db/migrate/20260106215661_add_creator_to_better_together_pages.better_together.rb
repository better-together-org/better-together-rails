# frozen_string_literal: true

# This migration comes from better_together (originally 20251229120000)
# Add creator_id column to pages table
class AddCreatorToBetterTogetherPages < ActiveRecord::Migration[7.2]
  def change
    change_table :better_together_pages, &:bt_creator
  end
end
