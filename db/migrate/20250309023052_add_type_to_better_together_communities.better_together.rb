# frozen_string_literal: true

# This migration comes from better_together (originally 20240911235546)
class AddTypeToBetterTogetherCommunities < ActiveRecord::Migration[7.1]
  def change
    add_column :better_together_communities, :type, :string, null: false, default: 'BetterTogether::Community'
  end
end
