# frozen_string_literal: true

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.args << '--headless'
  options.args << '--disable-gpu'
  options.args << '--no-sandbox'
  options.args << '--disable-dev-shm-usage'
  options.args << '--lang=ja-JP'
  options.args << '--window-size=800,600'
  options.args << '--disable-dev-shm-usage'

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    capabilities: options
  )
end

Capybara.configure do |config|
  config.default_driver    = :rack_test
  config.javascript_driver = :selenium_chrome_headless
  config.raise_server_errors = false
  config.default_max_wait_time = 5
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end
