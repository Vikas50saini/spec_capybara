require 'spec_helper'
require 'capybara/dsl'
require 'yaml'

shared_context "Login saucedemo" do |username, password|
  before(:each) do
    visit 'https://www.saucedemo.com/'
    fill_in 'user-name', with: username
    fill_in 'password', with: password
    click_button 'login-button'
  end
  after(:each) do
    click_button("Open Menu")
    sleep 2
    click_link("Logout")
    sleep 2
  end
end

RSpec.shared_examples "Login with userData.yml file data" do |username, password|
  include Capybara::DSL

  include_context "Login saucedemo",username, password
  it "change shorting with logged in username" do
    click_on 'add-to-cart-sauce-labs-backpack'
    sleep 2
    find(:css, ".product_sort_container").find(:option, "Name (Z to A)").select_option
    sleep 2
  end
end

RSpec.describe 'saucedemo', type: :feature do
  include Capybara::DSL
  user_data = YAML.load_file("/Users/vikas/Documents/spec_capybara_tests/fixtures/userData.yml")

  user_data.each do |user, data|
    username = data['username']
    password = data['password']
    it_behaves_like "Login with userData.yml file data",username,password
  end
end
