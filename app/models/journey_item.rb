# frozen_string_literal: true

class JourneyItem < ApplicationRecord
  include BetterTogether::Positioned
  belongs_to :journey
  belongs_to :journey_stage, optional: true
  belongs_to :journeyable, polymorphic: true
  has_one :person, through: :journey

  scope :positioned, -> { order(:journey_stage_id, :position) }

  def position_scope
    :journey_stage_id
  end

  def to_s
    journeyable.to_s
  end
end
