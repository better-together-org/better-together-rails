# frozen_string_literal: true

# This migration comes from better_together (originally 20251107221537)
# Adds protected column to prevent deletion of platform-critical blocks
class AddProtectedToBetterTogetherContentBlocks < ActiveRecord::Migration[7.2]
  def change
    change_table :better_together_content_blocks, bulk: true, &:bt_protected
  end
end
