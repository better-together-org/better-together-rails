# This migration comes from better_together (originally 20240522203205)
class CreatePrimaryCommunitiesForExistingPeople < ActiveRecord::Migration[7.0]
  def up
    BetterTogether::Person.where(community_id: nil).each do |person|
      person.save!
    end
  end

  def down; end
end
