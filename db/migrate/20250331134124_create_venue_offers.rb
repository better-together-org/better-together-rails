# frozen_string_literal: true

class CreateVenueOffers < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :venue_offers, prefix: nil do |t|
      t.bt_creator
      t.bt_identifier
      t.bt_position
      t.bt_primary_flag(parent_key: :venue_id)
      t.bt_privacy

      t.boolean :accommodations_provided, null: false, default: false
      t.text :accomodations_notes

      t.boolean :box_office, null: false, default: false

      t.text :financial_notes
      t.text :marketing_support

      t.bt_references :stage, target_table: :stages
      t.bt_references :venue, target_table: :venues
    end
  end
end
