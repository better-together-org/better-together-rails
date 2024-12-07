# frozen_string_literal: true

class ChangeSlugColumnNullOnResources < ActiveRecord::Migration[7.1] # rubocop:todo Style/Documentation
  def change
    remove_column :better_together_resources, :slug
  end
end
