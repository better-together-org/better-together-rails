# frozen_string_literal: true

# Join table between Venue and BetterTogether::Infrastructure::Building
class CreateVenueBuildings < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :venue_buildings, prefix: nil do |t|
      t.bt_references :building, target_table: :better_together_infrastructure_buildings, null: false
      t.bt_references :venue, target_table: :venues, null: false
      t.bt_position
      t.bt_primary_flag(parent_key: :venue_id)
    end
  end
end
