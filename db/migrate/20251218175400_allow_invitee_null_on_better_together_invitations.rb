class AllowInviteeNullOnBetterTogetherInvitations < ActiveRecord::Migration[8.0]
  def change
    change_column_null :better_together_invitations, :invitee_type, true
    change_column_null :better_together_invitations, :invitee_id, true
  end
end
