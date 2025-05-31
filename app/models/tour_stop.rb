# frozen_string_literal: true

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
