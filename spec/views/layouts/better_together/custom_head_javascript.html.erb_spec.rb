# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/better_together/_custom_head_javascript.html.erb', type: :view do
  def with_gtag_id(value)
    original = ENV.fetch('GTAG_ID', nil)
    value.nil? ? ENV.delete('GTAG_ID') : ENV['GTAG_ID'] = value
    yield
  ensure
    original.nil? ? ENV.delete('GTAG_ID') : ENV['GTAG_ID'] = original
  end

  def render_partial_with(gtag_id:, nonce: 'nonce-123')
    allow(view).to receive(:content_security_policy_nonce).and_return(nonce)

    with_gtag_id(gtag_id) do
      render partial: 'layouts/better_together/custom_head_javascript'
    end
  end

  it 'adds the nonce to the external Google tag script' do
    render_partial_with(gtag_id: 'G-TEST123')

    expect(rendered).to include('https://www.googletagmanager.com/gtag/js?id=G-TEST123')
  end

  it 'adds the nonce to the inline Google tag bootstrap script' do
    render_partial_with(gtag_id: 'G-TEST123')

    expect(rendered).to include("gtag('config', 'G-TEST123');")
  end

  it 'applies the same nonce to both Google tag script elements' do
    render_partial_with(gtag_id: 'G-TEST123')

    expect(rendered.scan('nonce="nonce-123"').size).to eq(2)
  end

  it 'renders nothing when GTAG_ID is not present' do
    with_gtag_id(nil) do
      render partial: 'layouts/better_together/custom_head_javascript'
    end

    expect(rendered.strip).to eq('')
  end
end
