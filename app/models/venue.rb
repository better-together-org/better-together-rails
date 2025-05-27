# frozen_string_literal: true

# A place where entertainment performances are held
class Venue < ApplicationRecord # rubocop:todo Metrics/ClassLength
  include BetterTogether::Contactable
  include BetterTogether::Creatable
  include BetterTogether::Identifier
  include BetterTogether::PrimaryCommunity
  include BetterTogether::Privacy
  include BetterTogether::Searchable

  has_community(class_name: 'VenueCommunity')

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

  delegate :accessible, :capacity, :equipment_list, :lighting_tech, :sound_tech, :seating_chart, :specs, :stage_plot,
           :tech_specs, to: :primary_stage, allow_nil: true

  delegate :box_office, :accommodations_provided, :accomodations_notes, :financial_notes, :marketing_support,
           to: :primary_venue_offer, allow_nil: true

  delegate :person_community_memberships, :person_community_memberships_attributes=, to: :community

  after_create :create_map, if: ->(obj) { obj.map.nil? }
  after_update :create_map, if: ->(obj) { obj.map.nil? }

  translates :name
  translates :description, backend: :action_text

  slugged :name

  settings index: default_elasticsearch_index do
    mappings dynamic: 'false' do
      indexes :name, type: :text, analyzer: 'custom_analyzer', search_analyzer: 'standard', boost: 3
      indexes :description, type: :text, analyzer: 'custom_analyzer', search_analyzer: 'standard', boost: 2
      indexes :formatted_address, type: :text, analyzer: 'custom_analyzer', search_analyzer: 'standard', boost: 2
    end
  end

  def self.permitted_attributes(id: false, destroy: false)
    [
      stages_attributes: Stage.permitted_attributes(id: true, destroy: true),
      venue_buildings_attributes: VenueBuilding.permitted_attributes(id: true, destroy: true),
      venue_images_attributes: VenueImage.permitted_attributes(id: true, destroy: true),
      venue_offers_attributes: VenueOffer.permitted_attributes(id: true, destroy: true),
      person_community_memberships_attributes: BetterTogether::PersonCommunityMembership.permitted_attributes(id: true,
                                                                                                              # rubocop:todo Layout/LineLength
                                                                                                              destroy: true)
      # rubocop:enable Layout/LineLength
    ] + super
  end

  # Customize the data sent to Elasticsearch for indexing
  def as_indexed_json(_options = {})
    as_json(
      only: [:id],
      methods: [:name, :slug, :formatted_address, *self.class.localized_attribute_list.keep_if do |a|
        a.starts_with?('name') || a.starts_with?('description')
      end]
    )
  end

  def create_venue_map
    create_map(name:, zoom: 10)
  end

  def formatted_address
    @formatted_address ||= primary_address&.to_formatted_s(excluded: %i[postal_code country_name])
  end

  def primary_building
    return if venue_buildings.empty?

    @primary_building ||= venue_buildings.primary_record(id)&.building
  end

  def primary_address
    @primary_address ||= primary_building&.address
  end

  def primary_community_extra_attrs
    { privacy: 'private' }
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

  # rubocop:todo Metrics/MethodLength
  def leaflet_points # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
    buildings.joins(:space).map do |building|
      point = building.to_leaflet_point
      next if point.nil?

      point.merge(
        label: "<a href='#{Rails.application.routes.url_helpers.venue_path(
          self,
          locale: I18n.locale
        )}' class='text-decoration-none'><strong>#{name}</strong></a>",
        popup_html: "<a href='#{Rails.application.routes.url_helpers.venue_path(
          self,
          locale: I18n.locale
        )}' class='text-decoration-none'><strong>#{name}</strong></a><br>#{building.address}"
      )
    end.compact
  end
  # rubocop:enable Metrics/MethodLength

  def to_s
    name
  end
end
