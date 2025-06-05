# frozen_string_literal: true

# Association between a tour and a venue
class TourStop < ApplicationRecord
  include ::BetterTogether::Positioned

  belongs_to :tour
  belongs_to :venue

  def self.permitted_attributes(id: false, destroy: false)
    super + %i[
      venue_id tour_id
    ]
  end
end
