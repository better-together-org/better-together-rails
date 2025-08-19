# frozen_string_literal: true

# This migration comes from better_together (originally 20250715200500)
# Adds collective flag to agreements
class AddCollectiveToBetterTogetherAgreements < ActiveRecord::Migration[7.1]
  def change
    add_column :better_together_agreements, :collective, :boolean, default: false, null: false
  end
end
