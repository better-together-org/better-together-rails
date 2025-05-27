# frozen_string_literal: true

# Creates join table between venue invitation, venue, and role
class CreateVenueInvitationVenues < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :venue_invitation_venues, prefix: nil do |t|
      t.bt_references :role
      t.bt_references :venue, target_table: :venues
      t.bt_references :venue_invitation, target_table: :better_together_platform_invitations

      t.index %i[venue_id venue_invitation_id]
    end
  end
end
