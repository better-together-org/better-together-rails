# frozen_string_literal: true

# This migration comes from better_together (originally 20240522204901)
class SetPeopleCommunityNullFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_null :better_together_people, :community_id, false
  end
end
