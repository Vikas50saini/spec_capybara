require 'spec_helper'
require 'capybara/dsl'

RSpec.describe 'Google Search', type: :feature do
  include Capybara::DSL

  it 'Window handling Tests' do
    visit 'https://demoqa.com/browser-windows'
    main_window = page #storing main window object
    new_window = window_opened_by do # opening a new window and storing new window object
      click_button 'New Window'
    end
    within_window new_window do # performing actions on new window
      expect(find("#sampleHeading").text).to eql("This is a sample page")
    end
    new_window.close #closing the new window
    current_url = page.current_url
    puts "Current URL: #{current_url}" #print main window url
    expect(current_url).to eql("https://demoqa.com/browser-windows")
    sleep 5
  end
end
