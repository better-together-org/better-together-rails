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

  belongs_to :tech_specs, class_name: 'BetterTogether::Upload', dependent: :destroy

  belongs_to :stage_plot, class_name: 'BetterTogether::Upload', dependent: :destroy

  belongs_to :seating_chart, class_name: 'BetterTogether::Upload', dependent: :destroy

  translates :name
  translates :description, backend: :action_text
  translates :specs, backend: :action_text

  accepts_nested_attributes_for :tech_specs, :stage_plot, :seating_chart,
                                allow_destroy: true, reject_if: :all_blank

  def self.permitted_attributes(id: false, destroy: false)
    %i[
      capacity equipment_list venue_id accessible lighting_tech sound_tech
    ] + [
      {
        tech_specs_attributes: BetterTogether::Upload.permitted_attributes(id: true, destroy: true),
        stage_plot_attributes: BetterTogether::Upload.permitted_attributes(id: true, destroy: true),
        seating_chart_attributes: BetterTogether::Upload.permitted_attributes(id: true, destroy: true)
      }
    ] + super
  end

  def seating_chart
    super || build_seating_chart
  end

  def stage_plot
    super || build_stage_plot
  end

  def tech_specs
    super || build_tech_specs
  end
end
