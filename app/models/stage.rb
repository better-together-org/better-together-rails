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

  belongs_to :tech_specs, class_name: 'BetterTogether::File', dependent: :destroy

  belongs_to :stage_plot, class_name: 'BetterTogether::File', dependent: :destroy

  belongs_to :seating_chart, class_name: 'BetterTogether::File', dependent: :destroy

  translates :name
  translates :description, backend: :action_text

  accepts_nested_attributes_for :tech_specs, :stage_plot, :seating_chart,
                                allow_destroy: true, reject_if: :all_blank

  def self.permitted_attributes(id: false, destroy: false)
    %i[
      capacity equipment_list venue_id
    ] + [
      {
        tech_specs_attributes: BetterTogether::File.permitted_attributes(id: true, destroy: true),
        stage_plot_attributes: BetterTogether::File.permitted_attributes(id: true, destroy: true),
        seating_chart_attributes: BetterTogether::File.permitted_attributes(id: true, destroy: true)
      }
    ] + super
  end

  def seating_chart
    super || build_seating_chart(identifier: "seating-chart-#{id}")
  end

  def stage_plot
    super || build_stage_plot(identifier: "stage-plot-#{id}")
  end

  def tech_specs
    super || build_tech_specs(identifier: "tech-specs-#{id}")
  end
end
