# frozen_string_literal: true

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
