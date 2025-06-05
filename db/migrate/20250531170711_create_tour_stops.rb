# frozen_string_literal: true

# Creates table to track association between tours and venues
class CreateTourStops < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :tour_stops, prefix: nil do |t|
      t.bt_position
      t.bt_references :tour, target_table: :tours, null: false
      t.bt_references :venue, target_table: :venues, null: false

      t.datetime :arrives_at, index: { name: 'tour_stops_by_arrives_at' }
      t.datetime :departs_at, index: { name: 'tour_stops_by_departs_at' }
    end
  end
end
