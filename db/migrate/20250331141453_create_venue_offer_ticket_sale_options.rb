# frozen_string_literal: true

# Add join table between venue offers and ticket sale options
# This table allows for the association of multiple ticket sale options with a venue offer
# and a deal type.
#
# The table is created with the following columns:
# - id: primary key
# - bt_position: position of the record in the list
# - deal_type_id: foreign key to the deal_types table
# - ticket_sale_option_id: foreign key to the ticket_sale_options table
# - venue_offer_id: foreign key to the venue_offers table
#
# The table is indexed on deal_type_id, ticket_sale_option_id, and venue_offer_id for performance.
class CreateVenueOfferTicketSaleOptions < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :venue_offer_ticket_sale_options, prefix: nil do |t|
      t.bt_position
      t.bt_references :deal_type, target_table: :deal_types
      t.bt_references :ticket_sale_option, target_table: :ticket_sale_options
      t.bt_references :venue_offer, target_table: :venue_offers
    end
  end
end
