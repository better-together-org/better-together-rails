# frozen_string_literal: true

# This migration comes from better_together (originally 20251230145743)
# Adds creator tracking to invitations table for accountability
class AddCreatorToInvitations < ActiveRecord::Migration[7.2]
  def change
    change_table :better_together_invitations, &:bt_creator
  end
end
