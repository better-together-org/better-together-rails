# frozen_string_literal: true

class Stage < ApplicationRecord
  include BetterTogether::Creatable
  include BetterTogether::Identifier
  include BetterTogether::Positioned
  include BetterTogether::PrimaryFlag
  include BetterTogether::Privacy
  include BetterTogether::Translatable

  primary_flag_scope(:venue_id)

  belongs_to :venue

  has_one_attached :tech_specs

  has_one_attached :stage_plot

  has_one_attached :seating_chart

  translates :name
  translates :description, backend: :action_text

  def self.permitted_attributes(id: false, destroy: false)
    %i[
      capacity equipment_list venue_id
    ] + super
  end
end
