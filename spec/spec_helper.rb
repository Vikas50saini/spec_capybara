require 'capybara/rspec'
require 'selenium-webdriver'
require 'rspec/retry'
require 'parallel_tests'
require 'simplecov'

SimpleCov.start do
  merge_timeout 3600  # Increase the timeout if you have a large test suite
end
headless_mode = ENV['HEADLESS_MODE'] == 'true'
Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--no-sandbox') # Optional: Address potential sandbox issues
  if headless_mode
    options.add_argument('--headless')
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome

session = Capybara.current_session.driver.browser
session.manage.window.maximize

RSpec.configure do |config|
  if ENV['TEST_ENV_NUMBER']
    report_file = "report_#{ENV['TEST_ENV_NUMBER']}.html"
  else
    report_file = 'report.html'
  end
  config.add_formatter('html', report_file)

  config.verbose_retry = true
  config.display_try_failure_messages = true
  config.default_retry_count = 3

  config.after do |example|
    if example.exception
      screenshot = Capybara.page.driver.browser.screenshot_as(:png)
      screenshot_file = "screenshot-#{example.full_description}.png"
      File.open(screenshot_file, 'wb') do |f|
        f.write screenshot
      end
      puts "Screenshot saved to #{screenshot_file}"
    end
  end
end
