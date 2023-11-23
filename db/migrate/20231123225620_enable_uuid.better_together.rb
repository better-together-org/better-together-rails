# This migration comes from better_together (originally 20231115153613)
class EnableUuid < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto'
  end
end
