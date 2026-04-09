# frozen_string_literal: true

class ExpandAuthorshipsIntoContributions < ActiveRecord::Migration[7.2]
  ROLE_INDEX_NAME = 'by_better_together_authorships_role'
  CONTRIBUTION_TYPE_INDEX_NAME = 'by_better_together_authorships_contribution_type'
  AUTHORABLE_ROLE_INDEX_NAME = 'by_better_together_authorships_authorable_role'

  def change
    change_table :better_together_authorships, bulk: true do |t|
      t.string :role, null: false, default: 'author' unless column_exists?(:better_together_authorships, :role)
      t.string :contribution_type, null: false, default: 'content' unless column_exists?(:better_together_authorships, :contribution_type)
      t.jsonb :details, null: false, default: {} unless column_exists?(:better_together_authorships, :details)
    end

    add_index :better_together_authorships, :role, name: ROLE_INDEX_NAME unless index_exists?(
      :better_together_authorships, :role, name: ROLE_INDEX_NAME
    )
    add_index :better_together_authorships,
              :contribution_type,
              name: CONTRIBUTION_TYPE_INDEX_NAME unless index_exists?(
                :better_together_authorships, :contribution_type, name: CONTRIBUTION_TYPE_INDEX_NAME
              )
    add_index :better_together_authorships,
              %i[authorable_type authorable_id role],
              name: AUTHORABLE_ROLE_INDEX_NAME unless index_exists?(
                :better_together_authorships,
                %i[authorable_type authorable_id role],
                name: AUTHORABLE_ROLE_INDEX_NAME
              )
  end
end
