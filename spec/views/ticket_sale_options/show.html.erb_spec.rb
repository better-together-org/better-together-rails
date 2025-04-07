# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ticket_sale_options/show', type: :view do
  before do
    assign(:ticket_sale_option, TicketSaleOption.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
