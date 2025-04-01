# frozen_string_literal: true

class CreateStages < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :stages, prefix: nil do |t|
      t.bt_creator
      t.bt_identifier
      t.bt_position
      t.bt_privacy
      t.bt_primary_flag(parent_key: :venue_id)

      t.boolean :accessible, null: false, default: false
      t.integer :capacity

      t.text :equipment_list

      t.string :location # indoor, outdoor, portable, etc

      t.boolean :lighting_tech, null: false, default: false
      t.boolean :sound_tech, null: false, default: false

      t.bt_references :venue, target_table: :venues
    end
  end
end
