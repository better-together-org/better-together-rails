# frozen_string_literal: true

# This migration comes from better_together (originally 20240906132628)
# Cleans up unused columns on pages table
class RemoveUnusedColumnsFromBetterTogetherPages < ActiveRecord::Migration[7.1]
  def change
    remove_column :better_together_pages, :language
    remove_column :better_together_pages, :published
  end
end
