# frozen_string_literal: true

# Creates the venue_offer_deal_types table with a many-to-many relationship between
# venue_offers and deal_types. This table allows for the association of multiple
# deal_types with a single venue_offer and vice versa.
#
# The table includes a position column for ordering the associations.
#
# @see VenueOffer
# @see DealType
#
# @note This migration leverages the BT (Better Together) gem, which provides
#       a set of tools for managing many-to-many relationships in Rails.
class CreateVenueOfferDealTypes < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :venue_offer_deal_types, prefix: nil do |t|
      t.bt_position
      t.bt_references :deal_type, target_table: :deal_types
      t.bt_references :venue_offer, target_table: :venue_offers
    end
  end
end
