# frozen_string_literal: true

# This migration comes from better_together (originally 20241003180137)
class AddCreatorPrivacyAndVisibleColumnsToBetterTogetherContentBlocks < ActiveRecord::Migration[7.1]
  def change
    change_table :better_together_content_blocks do |t|
      t.bt_creator
      t.bt_privacy
      t.bt_visible

      t.jsonb :content_area_settings, null: false, default: {}
    end
  end
end
