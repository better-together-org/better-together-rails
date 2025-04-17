# frozen_string_literal: true

# Join record between a ticket sale option and a venue offer
class VenueOfferTicketSaleOption < ApplicationRecord
  include BetterTogether::Positioned
  include BetterTogether::Translatable

  belongs_to :ticket_sale_option
  belongs_to :venue_offer

  translates :name
  translates :description, backend: :action_text
end
