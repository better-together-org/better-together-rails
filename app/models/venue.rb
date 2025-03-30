# frozen_string_literal: true

# A place where entertainment performances are held
class Venue < ApplicationRecord
  include BetterTogether::Contactable
  include BetterTogether::Creatable
  include BetterTogether::Identifier
  include BetterTogether::PrimaryCommunity
  include BetterTogether::Privacy
  include BetterTogether::Searchable

  has_many :venue_buildings,
           -> { order(:primary_flag, :position) }, dependent: :destroy
  has_many :buildings, through: :venue_buildings

  has_many :addresses, through: :buildings

  accepts_nested_attributes_for :venue_buildings, allow_destroy: true, reject_if: :all_blank

  translates :name
  translates :description, backend: :action_text

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, as: 'name'
      indexes :description, as: 'description'
      indexes :rich_text_content, type: 'nested' do
        indexes :body, type: 'text'
      end
      indexes :rich_text_translations, type: 'nested' do
        indexes :body, type: 'text'
      end
    end
  end

  def self.extra_permitted_attributes
    super + [
      venue_buildings_attributes: [
        :venue_id,
        *VenueBuilding.permitted_attributes(id: true, destroy: true),
        {
          building_attributes: ::BetterTogether::Infrastructure::Building.permitted_attributes(id: true)
        }
      ]
    ]
  end

  def primary_building
    return if venue_buildings.empty?

    @primary_building ||= venue_buildings.primary_record(id)&.building
  end

  def primary_address
    @primary_address ||= primary_building&.address
  end

  def to_s
    name
  end
end
