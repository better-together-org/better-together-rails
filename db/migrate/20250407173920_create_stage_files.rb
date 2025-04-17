# frozen_string_literal: true

# Add foreign keys to stages for seating_chart, stage_plot, and tech_specs files
class CreateStageFiles < ActiveRecord::Migration[7.1]
  def change
    change_table :stages do |t|
      t.bt_references :seating_chart, null: true, target_table: :better_together_files,
                                      fk_options: { on_delete: :nullify }
      t.bt_references :stage_plot, null: true, target_table: :better_together_files, fk_options: { on_delete: :nullify }
      t.bt_references :tech_specs, null: true, target_table: :better_together_files, fk_options: { on_delete: :nullify }
    end
  end
end
