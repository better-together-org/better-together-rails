# frozen_string_literal: true

# This migration comes from better_together (originally 20240915212739)
class CreateBetterTogetherCategorizations < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :categorizations do |t|
      t.bt_references :category, polymorphic: true, null: false

      t.bt_references :categorizable, polymorphic: true, null: false
    end
  end
end
