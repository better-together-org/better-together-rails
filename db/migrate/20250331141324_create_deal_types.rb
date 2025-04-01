# frozen_string_literal: true

class CreateDealTypes < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :deal_types, prefix: nil, &:bt_identifier
  end
end
