# frozen_string_literal: true

# Creates the deal_types table, which stores information about different types of deals.
class CreateDealTypes < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :deal_types, prefix: nil, &:bt_identifier
  end
end
