# frozen_string_literal: true

class CreateTours < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :tours, prefix: nil do |t|
      t.bt_creator
      t.bt_identifier
      t.bt_privacy

      t.datetime :starts_at, index: { name: 'tours_by_starts_at' }
      t.datetime :ends_at, index: { name: 'tours_by_ends_at' }
    end
  end
end
