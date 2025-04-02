require 'rails_helper'

RSpec.describe "ticket_sale_options/edit", type: :view do
  let(:ticket_sale_option) {
    TicketSaleOption.create!()
  }

  before(:each) do
    assign(:ticket_sale_option, ticket_sale_option)
  end

  it "renders the edit ticket_sale_option form" do
    render

    assert_select "form[action=?][method=?]", ticket_sale_option_path(ticket_sale_option), "post" do
    end
  end
end
