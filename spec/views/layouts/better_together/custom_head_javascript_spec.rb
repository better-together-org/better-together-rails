# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/better_together/_custom_head_javascript', type: :view do
  before do
    allow(view).to receive(:content_security_policy_nonce).and_return('nonce-123')
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with('GTAG_ID').and_return('G-TEST123')
  end

  it 'renders both Google Tag scripts with the active CSP nonce', :aggregate_failures do
    render partial: 'layouts/better_together/custom_head_javascript'

    expect(rendered).to include('https://www.googletagmanager.com/gtag/js?id=G-TEST123')
    expect(rendered.scan('nonce="nonce-123"').size).to eq(2)
    expect(rendered).to include("gtag('config', 'G-TEST123');")
  end
end
