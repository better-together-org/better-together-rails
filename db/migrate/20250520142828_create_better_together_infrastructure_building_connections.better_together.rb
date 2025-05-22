# frozen_string_literal: true

# This migration comes from better_together (originally 20250508171618)
# Creates the table for a polymorphic connection to buildings
class CreateBetterTogetherInfrastructureBuildingConnections < ActiveRecord::Migration[7.1]
  def change
    return if table_exists? :better_together_infrastructure_building_connections

    create_bt_table :building_connections, prefix: :better_together_infrastructure do |t|
      t.bt_references :building, target_table: :better_together_infrastructure_buildings, null: false,
                                 index: { name: 'bt_building_connections_building' }
      t.bt_references :connection, polymorphic: true, null: false, index: { name: 'bt_building_connections_connection' }
      t.bt_position
      t.bt_primary_flag(parent_key: :connection_id, index_base: :bt_building_connections)
    end
  end
end
