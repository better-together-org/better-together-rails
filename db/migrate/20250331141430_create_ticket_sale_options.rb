# frozen_string_literal: true

class CreateTicketSaleOptions < ActiveRecord::Migration[7.1]
  def change
    create_bt_table :ticket_sale_options, prefix: nil, &:bt_identifier
  end
end
