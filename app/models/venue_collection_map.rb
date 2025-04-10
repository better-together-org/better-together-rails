# frozen_string_literal: true

class VenueCollectionMap < VenueMap
  def self.records
    mappable_class.joins(buildings: [:space]).order(created_at: :desc)
  end

  def leaflet_points
    records.map(&:leaflet_points).flatten.uniq
  end

  def records
    self.class.records
  end

  def spaces
    records.map(&:spaces).flatten.uniq
  end
end
