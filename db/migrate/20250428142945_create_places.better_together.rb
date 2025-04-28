# frozen_string_literal: true

# This migration comes from better_together (originally 20250324134601)
# Creates table for Places
class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :places do |t|
      t.bt_community
      t.bt_creator
      t.bt_identifier
      t.bt_references :space, target_table: :better_together_geography_spaces,
                              null: false,
                              index: true
      t.bt_privacy
    end
  end
end
