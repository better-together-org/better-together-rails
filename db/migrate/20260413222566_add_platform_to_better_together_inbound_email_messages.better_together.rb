# frozen_string_literal: true

# This migration comes from better_together (originally 20260408012000)
class AddPlatformToBetterTogetherInboundEmailMessages < ActiveRecord::Migration[7.2]
  def change
    add_reference :better_together_inbound_email_messages,
                  :platform,
                  type: :uuid,
                  foreign_key: { to_table: :better_together_platforms }
  end
end
