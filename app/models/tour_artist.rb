# frozen_string_literal: true

# Association between a tour and an artist
class TourArtist < ApplicationRecord
  include ::BetterTogether::Positioned

  belongs_to :artist
  belongs_to :tour

  def self.permitted_attributes(id: false, destroy: false)
    super + %i[
      artist_id tour_id
    ]
  end
end
