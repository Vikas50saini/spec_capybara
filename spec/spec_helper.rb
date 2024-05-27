require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome
session = Capybara.current_session.driver.browser
session.manage.window.maximize

# to generate report:  bundle exec rspec --format html --out report.html
RSpec.configure do |config|
  config.add_formatter('html', 'report.html')
end