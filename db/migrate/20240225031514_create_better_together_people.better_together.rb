# frozen_string_literal: true

# This migration comes from better_together (originally 20190216205634)
# Creates people table
class CreateBetterTogetherPeople < ActiveRecord::Migration[7.0]
  def change
    create_bt_table :people do |t|
      t.bt_emoji_name
      t.bt_emoji_description
      t.string :handle, null: false, index: { unique: true }
    end
  end
end
