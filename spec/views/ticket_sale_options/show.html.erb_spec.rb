require 'rails_helper'

RSpec.describe "ticket_sale_options/show", type: :view do
  before(:each) do
    assign(:ticket_sale_option, TicketSaleOption.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
