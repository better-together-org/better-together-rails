# frozen_string_literal: true

# This migration comes from better_together (originally 20250814150000)
class AddCreatorToBetterTogetherAuthorships < ActiveRecord::Migration[7.1]
  def change
    add_column :better_together_authorships, :creator_id, :uuid
    add_index :better_together_authorships, :creator_id, name: 'by_better_together_authorships_creator'
  end
end
