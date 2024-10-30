# frozen_string_literal: true

class CreateJourneys < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :journeys, prefix: nil do |t|
      t.bt_references :person, null: false
    end

    reversible do |dir|
      dir.up do
        BetterTogether::Person.all.each(&:create_journey)
      end
    end
  end
end
