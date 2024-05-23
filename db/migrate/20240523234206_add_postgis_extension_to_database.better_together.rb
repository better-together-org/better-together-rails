# This migration comes from better_together (originally 20240520221152)
class AddPostgisExtensionToDatabase < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'postgis'
  end
end
