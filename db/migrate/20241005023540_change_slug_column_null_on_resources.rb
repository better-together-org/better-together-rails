# frozen_string_literal: true

class ChangeSlugColumnNullOnResources < ActiveRecord::Migration[7.1]
  def change
    change_column_null :resources, :slug, true
  end
end
