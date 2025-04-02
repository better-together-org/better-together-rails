require 'rails_helper'

RSpec.describe "ticket_sale_options/new", type: :view do
  before(:each) do
    assign(:ticket_sale_option, TicketSaleOption.new())
  end

  it "renders new ticket_sale_option form" do
    render

    assert_select "form[action=?][method=?]", ticket_sale_options_path, "post" do
    end
  end
end
