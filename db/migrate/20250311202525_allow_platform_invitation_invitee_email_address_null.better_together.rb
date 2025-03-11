# frozen_string_literal: true

# This migration comes from better_together (originally 20250311133642)
# Allows creating invitations not associated with an email address
class AllowPlatformInvitationInviteeEmailAddressNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :better_together_platform_invitations, :invitee_email, true
  end
end
