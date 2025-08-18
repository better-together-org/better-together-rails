# frozen_string_literal: true

# This migration comes from better_together (originally 20250817164415)
class AddDefaultLabelToAddresses < ActiveRecord::Migration[7.1] # rubocop:todo Style/Documentation
  def change
    change_column_default :better_together_addresses, :label, 'main'
  end
end
