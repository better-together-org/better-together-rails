# frozen_string_literal: true

# This migration allows the invitee_type and invitee_id columns
# in the better_together_invitations table to be null.
# This change is necessary to accommodate invitations that invite people by email.
class AllowInviteeNullOnBetterTogetherInvitations < ActiveRecord::Migration[8.0]
  def change
    change_column_null :better_together_invitations, :invitee_type, true
    change_column_null :better_together_invitations, :invitee_id, true
  end
end
