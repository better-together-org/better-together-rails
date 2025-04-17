# frozen_string_literal: true

# Allows venues to offer deals to artists
class VenueOffer < ApplicationRecord
  include BetterTogether::Creatable
  include BetterTogether::Identifier
  include BetterTogether::Positioned
  include BetterTogether::PrimaryFlag
  include BetterTogether::Privacy
  include BetterTogether::Translatable

  primary_flag_scope(:venue_id)

  has_many :venue_offer_deal_types, dependent: :destroy

  has_many :deal_types, through: :venue_offer_deal_types

  has_many :venue_offer_ticket_sale_options, dependent: :destroy

  has_many :ticket_sale_options, through: :venue_offer_ticket_sale_options

  belongs_to :stage, optional: true

  translates :name
  translates :description, backend: :action_text

  def self.permitted_attributes(id: false, destroy: false)
    %i[
      accomodations_notes accommodations_provided financial_notes marketing_support venue_id
    ] + [
      {
        deal_type_ids: [],
        ticket_sale_option_ids: []
      }
    ] + super
  end

  def box_office
    @box_office ||= super || ticket_sale_options.where(identifier: %w[box_office box-office]).exists?
  end
end
