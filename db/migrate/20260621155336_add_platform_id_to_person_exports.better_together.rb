# frozen_string_literal: true

# This migration comes from better_together (originally 20260606001010)
# Phase 5 — PersonDataExport and PersonDeletionRequest isolation.
# Records the platform where the GDPR request was submitted (audit trail).
# Nullable; backfill assigns host platform to pre-existing records.
class AddPlatformIdToPersonExports < ActiveRecord::Migration[7.2]
  def change
    add_reference :better_together_person_data_exports, :platform,
                  type: :uuid,
                  null: true,
                  foreign_key: { to_table: :better_together_platforms },
                  index: true

    add_reference :better_together_person_deletion_requests, :platform,
                  type: :uuid,
                  null: true,
                  foreign_key: { to_table: :better_together_platforms },
                  index: true
  end
end
