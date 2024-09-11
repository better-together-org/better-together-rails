# frozen_string_literal: true

# This migration comes from better_together (originally 20240905203412)
# Allows for dynamic dispatch of url helpers instead of hard-coded urls
class AddRouteNameToBetterTogetherNavigationItems < ActiveRecord::Migration[7.1]
  def change
    add_column :better_together_navigation_items, :route_name, :string
  end
end
