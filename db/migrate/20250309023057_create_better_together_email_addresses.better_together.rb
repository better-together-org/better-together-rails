# frozen_string_literal: true

# This migration comes from better_together (originally 20240921161849)
class CreateBetterTogetherEmailAddresses < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :email_addresses do |t|
      t.string :email, null: false
      t.bt_label
      t.bt_privacy('better_together_email_addresses')
      t.bt_references :contact_detail, null: false, foreign_key: { to_table: :better_together_contact_details }
    end
  end
end
