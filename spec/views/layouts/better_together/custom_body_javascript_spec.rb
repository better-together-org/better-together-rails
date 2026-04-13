# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/better_together/_custom_body_javascript', type: :view do
  before do
    allow(view).to receive(:content_security_policy_nonce).and_return('nonce-123')
  end

  it 'renders the scroll progress script with the active CSP nonce', :aggregate_failures do
    render partial: 'layouts/better_together/custom_body_javascript'

    expect(rendered).to include('id="scroll-progress-bar"')
    expect(rendered).to include('nonce="nonce-123"')
    expect(rendered).to include('function createProgressBar()')
  end
end
