# frozen_string_literal: true

# This migration comes from better_together (originally 20241025150018)
class MigrateUnencryptedMessageContentAndDropColumn < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up do
        load 'tasks/data_migration.rake'
        Rake::Task['better_together:migrate_data:unencrypted_messages'].invoke
      end
    end
  end
end
