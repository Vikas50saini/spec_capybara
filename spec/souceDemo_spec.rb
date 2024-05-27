require 'spec_helper'
require 'capybara/dsl'

RSpec.describe 'Google Search', type: :feature do
  include Capybara::DSL

  it 'Login' do
    visit 'https://www.saucedemo.com/'
    fill_in 'user-name', with:"standard_user"
    fill_in 'password', with:"secret_sauce"
    click_button 'login-button'
    sleep 5
    click_on 'add-to-cart-sauce-labs-backpack'
    sleep 5
    find(:css, ".product_sort_container").find(:option, "Name (Z to A)").select_option
    sleep 5
  end
end
