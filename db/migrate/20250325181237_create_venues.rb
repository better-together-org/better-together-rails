# frozen_string_literal: true

# Creates Venues table
class CreateVenues < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :venues, prefix: nil do |t|
      t.bt_community
      t.bt_creator
      t.bt_identifier
      t.bt_privacy
    end
  end
end
