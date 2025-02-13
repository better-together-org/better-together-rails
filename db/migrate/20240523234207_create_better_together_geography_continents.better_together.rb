# frozen_string_literal: true

# This migration comes from better_together (originally 20240520221420)
class CreateBetterTogetherGeographyContinents < ActiveRecord::Migration[7.0]
  def change
    create_bt_table :continents, prefix: 'better_together_geography' do |t|
      t.bt_identifier
      t.bt_protected
      t.bt_community(:geography_continent)
      t.bt_slug
    end
  end
end
