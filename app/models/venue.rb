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

  has_many :venue_images,
           -> { order({ primary_flag: :desc }, { position: :asc }) }, dependent: :destroy

  has_many :images, through: :venue_images

  has_many :stages,
           -> { order(:primary_flag, :position) }, dependent: :destroy

  has_many :venue_offers,
           -> { order(:primary_flag, :position) }, dependent: :destroy

  has_many :deal_types, through: :venue_offers

  has_many :ticket_sale_options, through: :venue_offers

  has_one :map, class_name: 'BetterTogether::Geography::Map', as: :mappable, dependent: :destroy

  accepts_nested_attributes_for :venue_buildings, :venue_images, :venue_offers, :stages,
                                allow_destroy: true, reject_if: :all_blank

  delegate :accessible, :capacity, :equipment_list, :lighting_tech, :sound_tech, :seating_chart, :stage_plot,
           :tech_specs, to: :primary_stage, allow_nil: true
  delegate :box_office, :accommodations_provided, :accomodations_notes, :financial_notes, :marketing_support,
           to: :primary_venue_offer, allow_nil: true

  after_create :create_map, if: ->(obj) { obj.map.nil? }
  after_update :create_map, if: ->(obj) { obj.map.nil? }

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

  def self.permitted_attributes(id: false, destroy: false)
    [
      stages_attributes: Stage.permitted_attributes(id: true, destroy: true),
      venue_buildings_attributes: VenueBuilding.permitted_attributes(id: true, destroy: true),
      venue_images_attributes: VenueImage.permitted_attributes(id: true, destroy: true),
      venue_offers_attributes: VenueOffer.permitted_attributes(id: true, destroy: true)
    ] + super
  end

  def primary_building
    return if venue_buildings.empty?

    @primary_building ||= venue_buildings.primary_record(id)&.building
  end

  def primary_address
    @primary_address ||= primary_building&.address
  end

  def primary_image
    return if images.empty?

    @primary_image ||= venue_images.primary_record(id)&.image
  end

  def primary_stage
    return if stages.empty?

    @primary_stage ||= stages.primary_record(id)
  end

  def primary_venue_offer
    return if venue_offers.empty?

    @primary_venue_offer ||= venue_offers.primary_record(id)
  end

  def spaces
    @spaces ||= buildings.includes(:space).map(&:space).flatten.uniq
  end

  def leaflet_points
    buildings.includes(:space).map(&:to_leaflet_point).compact.to_json
  end

  def to_s
    name
  end
end
