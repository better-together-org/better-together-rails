# frozen_string_literal: true

module NlVenues
  module Building
    extend ActiveSupport::Concern

    included do
      has_many :venue_buildings,
               -> { order(:primary_flag, :position) }
      has_many :venues, through: :venue_buildings
    end
  end
end
