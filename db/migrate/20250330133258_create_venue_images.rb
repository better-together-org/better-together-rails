# frozen_string_literal: true

# Join table between Venue and BetterTogether::Content::Image (blocks table)
class CreateVenueImages < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :venue_images, prefix: nil do |t|
      t.bt_references :image, target_table: :better_together_content_blocks, null: false
      t.bt_references :venue, target_table: :venues, null: false
      t.bt_position
      t.bt_primary_flag(parent_key: :venue_id)
    end
  end
end
