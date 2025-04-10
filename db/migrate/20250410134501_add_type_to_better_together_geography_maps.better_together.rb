# frozen_string_literal: true

# This migration comes from better_together (originally 20250410133055)
class AddTypeToBetterTogetherGeographyMaps < ActiveRecord::Migration[7.1]
  def change
    add_column :better_together_geography_maps, :type, :string, null: false, default: 'BetterTogether::Geography::Map'
  end
end
