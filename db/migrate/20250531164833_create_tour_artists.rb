# frozen_string_literal: true

# Tracks association betwen tours and artists
class CreateTourArtists < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :tour_artists, prefix: nil do |t|
      t.bt_position
      t.bt_references :artist, target_table: :artists, null: false
      t.bt_references :tour, target_table: :tours, null: false
    end
  end
end
