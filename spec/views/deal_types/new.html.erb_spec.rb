# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'deal_types/new', type: :view do
  before do
    assign(:deal_type, DealType.new)
  end

  it 'renders new deal_type form' do
    render

    assert_select 'form[action=?][method=?]', deal_types_path, 'post' do
    end
  end
end
