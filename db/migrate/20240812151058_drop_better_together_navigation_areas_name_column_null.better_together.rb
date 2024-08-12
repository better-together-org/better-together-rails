# frozen_string_literal: true

# This migration comes from better_together (originally 20240812140527)
# Drop column null on BetterTogether::NavigationAreas#name
class DropBetterTogetherNavigationAreasNameColumnNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :better_together_navigation_areas, :name, false
  end
end
