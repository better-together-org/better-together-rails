# frozen_string_literal: true

# Join record between a deal type and a venue offer
class VenueOfferDealType < ApplicationRecord
  include BetterTogether::Positioned
  include BetterTogether::Translatable

  belongs_to :deal_type
  belongs_to :venue_offer

  translates :name
  translates :description, backend: :action_text
end
