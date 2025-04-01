# frozen_string_literal: true

class VenueOfferDealType < ApplicationRecord
  include BetterTogether::Identifier
  include BetterTogether::Positioned
  include BetterTogether::Translatable

  belongs_to :deal_type
  belongs_to :venue_offer

  translates :name
  translates :description, backend: :action_text
end
