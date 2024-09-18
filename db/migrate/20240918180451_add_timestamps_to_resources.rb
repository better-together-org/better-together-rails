class AddTimestampsToResources < ActiveRecord::Migration[7.1]
  def change
    default_time = Time.zone.now
    add_timestamps :resources, null: false, default: default_time, if_not_exists: true
    add_column :resources, :lock_version, :integer, null: false, default: 0, if_not_exists: true

    reversible do |dir|
      dir.up do
        change_column_default :resources, :created_at, from: default_time, to: nil
        change_column_default :resources, :updated_at, from: default_time, to: nil
      end
    end
  end
end
