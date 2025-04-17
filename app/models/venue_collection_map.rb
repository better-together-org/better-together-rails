# frozen_string_literal: true

# Custom collection map for venues
# This class is used to create a map of venues, which are collections of spaces
# and buildings. It inherits from VenueMap and overrides the records method to
# return a collection of venues ordered by their creation date.
#
# @see VenueMap
#
# @example
#   venue_map = VenueCollectionMap.new
#   venue_map.records # => returns a collection of venues ordered by creation date
#
# @note This class is used for creating maps of venues in the application and rendered on the venues index view.
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
