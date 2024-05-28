require 'spec_helper'
require 'capybara/dsl'

RSpec.describe 'Google Search', type: :feature do
  include Capybara::DSL

  it 'Elements Finding Tests' do
    visit 'https://artoftesting.com/samplesiteforselenium'
    fill_in "fname", with: "vikas" # id = fname
    # print "First Name: "+find_field("fname").value
    # or
    print "First Name: "+find_field(id: "fname").value
    sleep 5

    link=find_link('This is a link', :visible => :all)
    puts "Is link visible: #{link.visible?}"

    #find_button("idOfButton").click # id: idOfButton
    # or
    find_button(text: "Submit").click

    #find(:xpath,"//div[@id='commonWebElements']//a").click
    find("#commonWebElements").find("a").click

    # links = all('a')
    # links.each do |link|
    # puts link[:href]
    # end
    # or
    all('a').each { |a| puts a[:href] }
    sleep 5
  end
end
