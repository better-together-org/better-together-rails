# frozen_string_literal: true

class CreateJourneyItems < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :journey_items, prefix: nil do |t|
      t.bt_references :journey, null: false, target_table: :journeys
      t.bt_references :journey_stage, null: true, target_table: :better_together_categories
      t.bt_references :journeyable, polymorphic: true
      t.bt_position
    end
  end
end
