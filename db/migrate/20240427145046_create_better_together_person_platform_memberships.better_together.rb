# frozen_string_literal: true

# This migration comes from better_together (originally 20240422002405)
# Creates table for tracking a person's platform memberships
class CreateBetterTogetherPersonPlatformMemberships < ActiveRecord::Migration[7.0]
  def change
    create_bt_membership_table :person_platform_memberships,
                               member_type: :person,
                               joinable_type: :platform
  end
end
