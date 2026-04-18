# frozen_string_literal: true

# This migration comes from better_together (originally 20260415180000)
class AddLifecycleFieldsToBetterTogetherAgreements < ActiveRecord::Migration[7.2]
  def change
    change_table :better_together_agreements, bulk: true do |t|
      t.string :lifecycle_state, null: false, default: 'active'
      t.boolean :requires_reacceptance, null: false, default: false
      t.text :change_summary
    end

    add_index :better_together_agreements, :lifecycle_state
  end
end
