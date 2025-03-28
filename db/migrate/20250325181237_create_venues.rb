# frozen_string_literal: true

# Creates Venues table
class CreateVenues < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :venues, prefix: nil do |t|
      t.bt_references :building, target_table: :better_together_infrastructure_buildings
      t.bt_community
      t.bt_creator
      t.bt_identifier
      t.bt_privacy

      t.integer :floors_count, default: 0, null: false
      t.integer :rooms_count, default: 0, null: false
    end
  end
end
