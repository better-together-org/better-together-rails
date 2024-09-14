class CreateResources < ActiveRecord::Migration[7.1]
  def change
    create_table :resources, id: :uuid do |t|
      t.bt_identifier
      t.bt_locale('resources')
      t.bt_privacy('resources')
      t.bt_slug
      t.string :type, null: false, default: 'Resource'
      t.string :url
      t.datetime :published_at
      t.string :author
    end
  end
end
