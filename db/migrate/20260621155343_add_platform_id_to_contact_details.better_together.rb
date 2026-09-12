# frozen_string_literal: true

# This migration comes from better_together (originally 20260607001005)
# Phase 6 — Platform isolation for ContactDetail hierarchy.
# ContactDetail is owned by platform-scoped Person; must inherit platform_id.
class AddPlatformIdToContactDetails < ActiveRecord::Migration[7.2]
  def change
    return if column_exists?(:better_together_contact_details, :platform_id)

    add_reference :better_together_contact_details, :platform,
                  type: :uuid, null: true,
                  foreign_key: { to_table: :better_together_platforms },
                  index: true
  end
end
