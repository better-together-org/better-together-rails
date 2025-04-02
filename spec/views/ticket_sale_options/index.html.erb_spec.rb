require 'rails_helper'

RSpec.describe "ticket_sale_options/index", type: :view do
  before(:each) do
    assign(:ticket_sale_options, [
      TicketSaleOption.create!(),
      TicketSaleOption.create!()
    ])
  end

  it "renders a list of ticket_sale_options" do
    render
    cell_selector = 'div>p'
  end
end
