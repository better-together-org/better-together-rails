# frozen_string_literal: true

# This migration comes from better_together (originally 20250311134000)
# Ensure that the type column is present on BetterTogether::PlatformInvitation
class AddTypeToBetterTogetherPlatformInvitations < ActiveRecord::Migration[7.1]
  def change
    return if column_exists? :better_together_platform_invitations, :type

    add_column :better_together_platform_invitations, :type, :string, default: 'BetterTogether::PlatformInvitation',
                                                                      null: false
  end
end
