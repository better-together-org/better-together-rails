# frozen_string_literal: true

# This migration comes from better_together (originally 20250407171023)
class CreateBetterTogetherFiles < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :files do |t|
      t.bt_creator
      t.bt_identifier
      t.bt_privacy
      t.string :type, null: false, default: 'BetterTogether::File'
    end
  end
end
