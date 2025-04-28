# frozen_string_literal: true

# This migration comes from better_together (originally 20250329182120)
# Adds an address reference to the better_together_infrastructure_buildings table.
class AddAddressToBetterTogetherInfrastructureBuildings < ActiveRecord::Migration[7.1]
  def change
    change_table :better_together_infrastructure_buildings do |t|
      t.bt_references :address, target_table: :better_together_addresses, null: true
    end
  end
end
