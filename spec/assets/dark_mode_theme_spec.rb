# frozen_string_literal: true

require 'rails_helper'

# The colour-mode toggle sets data-bs-theme="dark". The header and footer are brand green, so they need a dark
# variant, or the page shows a pale panel with dark text (the mobile menu) under a dark page.
RSpec.describe 'Dark mode theme stylesheet' do # rubocop:disable RSpec/DescribeClass
  let(:css) { Rails.application.assets.find_asset('application.css').to_s }

  # Declarations of the rule whose selector list is exactly +selectors+, whatever whitespace sass emits.
  def rule_for(*selectors)
    pattern = selectors.map { |selector| selector.split.map { |part| Regexp.escape(part) }.join('\s+') }.join(',\s*')
    css[/(?:\A|\})\s*#{pattern}\s*\{([^}]*)\}/, 1].to_s
  end

  def color_pattern
    /#\h{3,6}\b|rgba?\([^)]*\)/
  end

  # Sass emits #rrggbb or rgb(r, g, b) with plain or percent channels.
  def to_rgb(color)
    color.start_with?('#') ? hex_channels(color) : function_channels(color)
  end

  def hex_channels(color)
    hex = color.delete('#')
    hex = hex.chars.map { |char| char * 2 }.join if hex.length == 3
    hex.scan(/../).map { |pair| pair.to_i(16) }
  end

  def function_channels(color)
    color.scan(/[\d.]+%?/).first(3).map { |number| number.end_with?('%') ? number.to_f * 2.55 : number.to_f }
  end

  def luminance(rgb)
    r, g, b = rgb.map do |value|
      channel = value / 255.0
      channel <= 0.03928 ? channel / 12.92 : ((channel + 0.055) / 1.055)**2.4
    end
    (0.2126 * r) + (0.7152 * g) + (0.0722 * b)
  end

  def contrast(foreground, background)
    light, dark = [luminance(to_rgb(foreground)), luminance(to_rgb(background))].sort.reverse
    (light + 0.05) / (dark + 0.05)
  end

  def declared(rule, property)
    rule[/(?:^|[;\s])#{property}:\s*(?:var\([^,)]+,\s*)?(#{color_pattern})/, 1]
  end

  it 'defines a dark header and footer with light text', :aggregate_failures do
    rule = rule_for('[data-bs-theme=dark] #main-nav')

    expect(rule).not_to be_empty
    expect(contrast(declared(rule, 'color'), declared(rule, 'background'))).to be >= 4.5
  end

  it 'keeps the light header colours for light mode' do
    expect(rule_for('#main-nav')).to match(/background:\s*var\(--bts-navbar-bg,\s*rgb\(/)
  end

  it 'gives the mobile bar dark colours with readable text', :aggregate_failures do
    root = css[/\[data-bs-theme=dark\]\s*\{([^}]*--bt-mobile-nav-bg[^}]*)\}/m, 1].to_s

    expect(root).to include('--bt-mobile-nav-bg')
    text = root[/--bt-mobile-nav-color:\s*var\([^,)]+,\s*(#{color_pattern})/, 1]
    background = root[/--bt-mobile-nav-bg:\s*var\([^,)]+,\s*(#{color_pattern})/, 1]

    expect(contrast(text, background)).to be >= 4.5
  end

  it 'prefers the platform theme tokens over the brand colours for the header and footer', :aggregate_failures do
    expect(rule_for('#main-nav')).to include('var(--bts-navbar-bg')
    expect(rule_for('#app-footer')).to include('var(--bts-footer-bg')
  end

  it 'uses a link colour with AA contrast on the dark header' do
    link = declared(rule_for('[data-bs-theme=dark] .navbar-nav .nav-link'), 'color')
    background = declared(rule_for('[data-bs-theme=dark] #main-nav'), 'background')

    expect(contrast(link, background)).to be >= 4.5
  end
end
