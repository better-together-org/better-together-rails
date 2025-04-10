# frozen_string_literal: true

class VenueMap < ::BetterTogether::Geography::Map
  def self.mappable_class
    ::Venue
  end
end
