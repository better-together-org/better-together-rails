# frozen_string_literal: true

require 'rails_helper'

# The host stylesheet used to paint #main-nav and #app-footer a fixed light green over any platform theme. With a
# theme set, the header and footer must take the theme's own colours in light and dark mode.
RSpec.describe 'Host header and footer follow the platform theme', :js, type: :feature do
  before { skip 'Chrome is not installed (set CI=true to require it)' unless ENV['CI'] || chrome_available? }

  def chrome_available?
    %w[google-chrome google-chrome-stable chromium chromium-browser].any? do |bin|
      system("command -v #{bin} > /dev/null 2>&1")
    end
  end

  def rgb(hex) = hex.delete('#').scan(/../).map { |pair| pair.to_i(16) }.join(', ')

  def computed_background(selector)
    page.evaluate_script("getComputedStyle(document.querySelector('#{selector}')).backgroundColor")
  end

  def themed_host(theme_id)
    host = BetterTogether::Platform.find_by(host: true) || create(:better_together_platform, :host)
    config = BetterTogether::PlatformThemeConfig.new(BetterTogether::PlatformThemeConfig.flat_theme(theme_id))
    host.update!(theme: config.values.merge('preset' => theme_id), privacy: 'public')
    config
  end

  def show_mode(mode)
    visit "/#{I18n.default_locale}"
    page.execute_script("document.documentElement.setAttribute('data-bs-theme', '#{mode}')")
  end

  %w[warm dark].each do |theme_id|
    %w[light dark].each do |mode|
      it "paints the #{theme_id} theme header and footer in #{mode} mode", :aggregate_failures do
        config = themed_host(theme_id)
        show_mode(mode)
        tokens = mode == 'dark' ? config.dark_values : config.values

        expect(computed_background('#main-nav')).to eq("rgb(#{rgb(tokens['navbar_bg'])})")
        expect(computed_background('#app-footer')).to eq("rgb(#{rgb(tokens['footer_bg'])})")
      end
    end
  end
end
