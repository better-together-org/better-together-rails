# frozen_string_literal: true

require 'rails_helper'

# Proves the Selenium + headless Chrome path works, so a missing or broken browser fails here with a clear
# name instead of inside the first real JavaScript spec. Locally it skips when Chrome is not installed;
# in CI (CI=true) a missing browser is a failure.
RSpec.describe 'Browser smoke', :js, type: :feature do
  def chrome_installed?
    %w[google-chrome google-chrome-stable chromium chromium-browser].any? do |bin|
      system("command -v #{bin} > /dev/null 2>&1")
    end
  end

  before { skip 'Chrome is not installed (set CI=true to require it)' unless ENV['CI'] || chrome_installed? }

  it 'loads a page and runs JavaScript' do
    visit '/healthcheck'

    expect(page.evaluate_script('1 + 1')).to eq(2)
  end
end
