require 'rails_helper'

RSpec.describe "deal_types/index", type: :view do
  before(:each) do
    assign(:deal_types, [
      DealType.create!(),
      DealType.create!()
    ])
  end

  it "renders a list of deal_types" do
    render
    cell_selector = 'div>p'
  end
end
