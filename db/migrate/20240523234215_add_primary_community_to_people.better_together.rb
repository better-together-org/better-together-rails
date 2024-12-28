# frozen_string_literal: true

# This migration comes from better_together (originally 20240522200922)
class AddPrimaryCommunityToPeople < ActiveRecord::Migration[7.0]
  def change
    change_table :better_together_people do |t|
      unless column_exists?(:better_together_people, :community_id, :uuid)
        # Custom community reference here to allow for null references for existing records
        t.bt_references :community, target_table: :better_together_communities, null: true,
                                    index: { name: 'by_person_community' }
      end
    end

    reversible do |dir|
      dir.up do
        BetterTogether::Person.where(community_id: nil).each(&:save!)
      end
    end
  end
end
