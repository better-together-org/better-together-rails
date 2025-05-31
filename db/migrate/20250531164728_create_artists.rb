# frozen_string_literal: true

class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :artists, prefix: nil do |t|
      t.bt_creator
      t.bt_identifier
      t.bt_privacy
    end
  end
end
