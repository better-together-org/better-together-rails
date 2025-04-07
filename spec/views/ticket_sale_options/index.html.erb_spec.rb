# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ticket_sale_options/index', type: :view do
  before do
    assign(:ticket_sale_options, [
             TicketSaleOption.create!,
             TicketSaleOption.create!
           ])
  end

  it 'renders a list of ticket_sale_options' do
    render
    'div>p'
  end
end
