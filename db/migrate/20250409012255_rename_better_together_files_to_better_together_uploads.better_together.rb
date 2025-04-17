# frozen_string_literal: true

# This migration comes from better_together (originally 20250409012010)
class RenameBetterTogetherFilesToBetterTogetherUploads < ActiveRecord::Migration[7.1]
  def change # rubocop:todo Metrics/MethodLength
    rename_table :better_together_files, :better_together_uploads, if_exists: true
    change_column_default :better_together_uploads, :type, from: 'BetterTogether::File', to: 'BetterTogether::Upload'
    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE better_together_uploads
          SET type = 'BetterTogether::Upload'
          WHERE type = 'BetterTogether::File'
        SQL

        # Update Active Storage attachments
        execute <<~SQL
          UPDATE active_storage_attachments
          SET record_type = 'BetterTogether::Upload'
          WHERE record_type = 'BetterTogether::File'
        SQL
      end
    end
  end
end
