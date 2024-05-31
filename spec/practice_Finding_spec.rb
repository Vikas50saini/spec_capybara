require 'spec_helper'
require 'capybara/dsl'

RSpec.describe "Finding Test Suit" do
  include Capybara::DSL
  before(:each) do
    visit "https://naveenautomationlabs.com/opencart/"
  end

  it 'Finding Tests' do
    find(:xpath, "//a[text()='Desktops']").hover
    mac = find(:xpath, "//a[text()='Mac (1)']", visible: true, wait: 10)
    mac.click
    add_to_cart = find(:xpath, "//span[text()='Add to Cart']", visible: true, wait: 10)
    puts add_to_cart.text
    puts add_to_cart.visible?
    if add_to_cart.visible? and add_to_cart.text == "ADD TO CART"
      add_to_cart.click
      success_msg = find(:xpath, "//*[normalize-space(text())='Success: You have added']", visible: true, wait: 10)
      expect(success_msg).to be_visible
      puts "Success: You have added"
    end
    a_tags=all("#menu li a")
    puts a_tags.length
    links = []
    a_tags.each do |tag|
      links.push(tag[:href])
    end

    links.each do |link|
      puts link
      visit link
      sleep 2
    end
    sleep 5
  end
end

