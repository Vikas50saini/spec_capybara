require 'spec_helper'
require 'capybara/dsl'

RSpec.shared_examples "switch_and_verify_window" do |exp_new_window_text, expected_url|
  # include Capybara::DSL
  # let(:main_window) { page }
  before(:each) do
    visit("https://demoqa.com/browser-windows")
  end

  it "opens a new window, verifies content, and closes it" do
    new_window = window_opened_by do # opening a new window and storing new window object
      click_button 'New Window'
    end
    within_window new_window do # performing actions on new window
      expect(find("#sampleHeading").text).to eql(exp_new_window_text)
    end
    new_window.close #closing the new window
    current_url = page.current_url
    puts "Current URL: #{current_url}" #print main window url
    expect(current_url).to eql(expected_url)
    sleep 5
  end
end

RSpec.describe 'Google Search', type: :feature do
  include Capybara::DSL
  # test with valid data
  it_behaves_like "switch_and_verify_window", "This is a sample page", "https://demoqa.com/browser-windows"  # Replace with actual expected values

  # test with invalid expurl
  it_behaves_like "switch_and_verify_window", "This is a sample page", "https://demoqa.com/browser-windows-new"

  # test with exp_new_window_text
  it_behaves_like "switch_and_verify_window", "This is an actual page", "https://demoqa.com/browser-windows-new"
end
