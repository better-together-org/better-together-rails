# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'deal_types/show', type: :view do
  before do
    assign(:deal_type, DealType.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
