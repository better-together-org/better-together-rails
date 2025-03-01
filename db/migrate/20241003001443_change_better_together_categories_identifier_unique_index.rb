# frozen_string_literal: true

# rubocop:todo Style/Documentation
class ChangeBetterTogetherCategoriesIdentifierUniqueIndex < ActiveRecord::Migration[7.1]
  # rubocop:enable Style/Documentation
  def change
    remove_index :better_together_categories, :identifier, if_exists: true
    add_index :better_together_categories, %i[identifier type], unique: true
  end
end
