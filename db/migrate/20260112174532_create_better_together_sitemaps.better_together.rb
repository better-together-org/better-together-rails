# frozen_string_literal: true

# This migration comes from better_together (originally 20250821120000)
# Migration to create the better_together_sitemaps table
class CreateBetterTogetherSitemaps < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :sitemaps do |t|
      t.bt_references :platform,
                      null: false,
                      index: { unique: true, name: 'unique_sitemaps_platform' }
    end
  end
end
