require 'spec_helper'
require 'capybara/dsl'

shared_context "saucedemo_login" do |username, password|
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

RSpec.describe "Login shopping cart app", type: :feature do
  include Capybara::DSL

  context "Logging in with username standard_user" do
    # loggin in with a set of username and passowrd
    include_context "saucedemo_login","standard_user", "secret_sauce"

    it "change shorting with logged in username as 'standard_user'" do
      click_on 'add-to-cart-sauce-labs-backpack'
      sleep 2
      find(:css, ".product_sort_container").find(:option, "Name (Z to A)").select_option
      sleep 2
    end
  end

  context "Logging in with username standard_user" do
    # loggin in with a set of different username and passowrd
    include_context "saucedemo_login","visual_user", "secret_sauce"

    it "change shorting with logged in username as 'visual_user'" do
      click_on 'add-to-cart-sauce-labs-backpack'
      sleep 2
      find(:css, ".product_sort_container").find(:option, "Name (Z to A)").select_option
      sleep 2
    end
  end
end
