# frozen_string_literal: true

# Custom Map subtype for Venues
class VenueMap < ::BetterTogether::Geography::Map
  def self.mappable_class
    ::Venue
  end
end
