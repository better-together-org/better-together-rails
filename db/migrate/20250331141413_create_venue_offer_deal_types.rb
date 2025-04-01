# frozen_string_literal: true

class CreateVenueOfferDealTypes < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :venue_offer_deal_types, prefix: nil do |t|
      t.bt_position
      t.bt_references :deal_type, target_table: :deal_types
      t.bt_references :venue_offer, target_table: :venue_offers
    end
  end
end
