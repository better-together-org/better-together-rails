# frozen_string_literal: true

# This migration comes from better_together (originally 20241025144852)
# Allows message content to be null in preparation to migrate to encrypted message contents
class RemoveMessagesContentColumnNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :better_together_messages, :content, true
  end
end
