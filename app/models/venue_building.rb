# frozen_string_literal: true

# Join model between Venue and BetterTogether::Infrastructure::Building
class VenueBuilding < ApplicationRecord
  include BetterTogether::Positioned
  include BetterTogether::PrimaryFlag

  primary_flag_scope(:venue_id)

  belongs_to :building,
             class_name: 'BetterTogether::Infrastructure::Building',
             dependent: :destroy
  belongs_to :venue

  accepts_nested_attributes_for :building, reject_if: :all_blank

  before_validation :set_new_building_details, if: :new_record?

  def self.permitted_attributes(id: false, destroy: false)
    [
      :venue_id,
      {
        building_attributes: ::BetterTogether::Infrastructure::Building.permitted_attributes(id: true)
      }
    ] + super
  end

  def building
    super || build_building
  end

  protected

  def set_new_building_details
    return unless venue

    building.name = venue.name
    building.description = venue.description
    building.privacy = venue.privacy
  end
end
