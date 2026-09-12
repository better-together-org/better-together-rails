# frozen_string_literal: true

# This migration comes from better_together (originally 20260606001003)
# Phase 5 — Upload isolation.
# Nullable; backfill assigns host platform to pre-existing records.
class AddPlatformIdToUploads < ActiveRecord::Migration[7.2]
  def change
    add_reference :better_together_uploads, :platform,
                  type: :uuid,
                  null: true,
                  foreign_key: { to_table: :better_together_platforms },
                  index: true
  end
end
