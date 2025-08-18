# frozen_string_literal: true

# This migration comes from better_together (originally 20250814150001)
# Adds urgency flags to JOATU offers and requests
class AddUrgencyToJoatuOffersRequests < ActiveRecord::Migration[7.0]
  def change
    change_table :better_together_joatu_offers, bulk: true do |t|
      t.string :urgency, default: 'normal', null: false
    end

    change_table :better_together_joatu_requests, bulk: true do |t|
      t.string :urgency, default: 'normal', null: false
    end
  end
end
