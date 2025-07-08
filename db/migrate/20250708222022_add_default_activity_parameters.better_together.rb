# frozen_string_literal: true

# This migration comes from better_together (originally 20250703214031)
class AddDefaultActivityParameters < ActiveRecord::Migration[7.1] # rubocop:todo Style/Documentation
  def change
    change_column_default :better_together_activities, :parameters, from: nil, to: '{}'
  end
end
