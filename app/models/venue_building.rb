# frozen_string_literal: true

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
