# frozen_string_literal: true

require 'capybara/rspec'
require 'tmpdir'

Capybara.server = :puma, { Silent: true }
Capybara.server_host = '127.0.0.1'
Capybara.always_include_port = true

# Same headless driver as community-engine-rails. The browser is the Chrome that ships on GitHub's ubuntu-latest
# runners (not the chromium-browser apt package, which pulls a snap from the Snap Store and fails when it times out).
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  %w[--headless --disable-gpu --no-sandbox --disable-dev-shm-usage --window-size=1400,1400].each do |arg|
    options.add_argument(arg)
  end
  options.add_argument("--user-data-dir=#{Dir.mktmpdir("chrome-#{Process.pid}-")}")

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options:,
    http_client: Selenium::WebDriver::Remote::Http::Default.new(
      read_timeout: Integer(ENV.fetch('SELENIUM_READ_TIMEOUT', 45))
    )
  )
end

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.default_driver = :rack_test
