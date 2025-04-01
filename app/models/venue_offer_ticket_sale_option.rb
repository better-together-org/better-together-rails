# frozen_string_literal: true

class VenueOfferTicketSaleOption < ApplicationRecord
  include BetterTogether::Identifier
  include BetterTogether::Positioned
  include BetterTogether::Translatable

  belongs_to :ticket_sale_option
  belongs_to :venue_offer

  translates :name
  translates :description, backend: :action_text
end
