# frozen_string_literal: true

# This migration comes from better_together (originally 20250703215419)
class AddPrivacyToActivities < ActiveRecord::Migration[7.1]
  def change
    change_table :better_together_activities, &:bt_privacy
  end
end
