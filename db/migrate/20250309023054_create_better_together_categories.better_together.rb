# frozen_string_literal: true

# This migration comes from better_together (originally 20240915212103)
class CreateBetterTogetherCategories < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :categories do |t|
      t.bt_identifier
      t.bt_slug
      t.bt_position
      t.bt_protected

      t.string :type, null: false, default: 'BetterTogether::Category'
    end
  end
end
