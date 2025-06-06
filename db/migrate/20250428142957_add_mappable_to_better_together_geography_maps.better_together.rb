# frozen_string_literal: true

# This migration comes from better_together (originally 20250407205544)
# Adds optional polymorphic mappable association to maps.
class AddMappableToBetterTogetherGeographyMaps < ActiveRecord::Migration[7.1]
  def change
    change_table :better_together_geography_maps do |t|
      t.bt_references :mappable, polymorphic: true, null: true
    end

    change_column_null :better_together_geography_maps, :center, true
  end
end
