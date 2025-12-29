# frozen_string_literal: true

# This migration comes from better_together (originally 20251223224253)
# Add status enum column to person membership tables
class AddStatusToPersonMemberships < ActiveRecord::Migration[7.2]
  def change
    add_column :better_together_person_platform_memberships, :status, :string, default: 'pending', null: false
    add_column :better_together_person_community_memberships, :status, :string, default: 'pending', null: false

    add_index :better_together_person_platform_memberships, :status
    add_index :better_together_person_community_memberships, :status
  end
end
