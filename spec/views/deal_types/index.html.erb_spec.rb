# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'deal_types/index', type: :view do
  before do
    assign(:deal_types, [
             DealType.create!,
             DealType.create!
           ])
  end

  it 'renders a list of deal_types' do
    render
    'div>p'
  end
end
