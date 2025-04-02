require 'rails_helper'

RSpec.describe "deal_types/edit", type: :view do
  let(:deal_type) {
    DealType.create!()
  }

  before(:each) do
    assign(:deal_type, deal_type)
  end

  it "renders the edit deal_type form" do
    render

    assert_select "form[action=?][method=?]", deal_type_path(deal_type), "post" do
    end
  end
end
