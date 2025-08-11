# frozen_string_literal: true

# This migration comes from better_together (originally 20250704100000)
# Adds creator reference to posts
class AddCreatorToBetterTogetherPosts < ActiveRecord::Migration[7.0]
  def change
    change_table :better_together_posts, &:bt_creator
  end
end
