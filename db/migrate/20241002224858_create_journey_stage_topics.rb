# frozen_string_literal: true

class CreateJourneyStageTopics < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :journey_stage_topics, prefix: nil do |t|
      t.bt_references :journey_stage, target_table: :better_together_categories
      t.bt_references :topic, target_table: :better_together_categories
      t.bt_position
      t.bt_visible

      t.index %i[journey_stage_id topic_id], unique: true
    end
  end
end
