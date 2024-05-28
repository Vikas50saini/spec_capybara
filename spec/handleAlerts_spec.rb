require 'spec_helper'
require 'capybara/dsl'

RSpec.describe 'Google Search', type: :feature do
  include Capybara::DSL

  it 'Handle Alerts Tests' do
    visit "https://demoqa.com/alerts"
    accept_alert 'You clicked a button' do
      sleep 2
      find(:css,"#alertButton").click
      sleep 5
    end
    sleep 5
  end

  it 'Handle Alerts that visible after 5 sec Tests' do
    visit "https://demoqa.com/alerts"
    accept_alert 'This alert appeared after 5 seconds' do
      sleep 5
      find(:css,"#timerAlertButton").click
      sleep 5
    end
    sleep 5
  end

  it 'Handle Confirm box Tests' do
    visit "https://demoqa.com/alerts"
    # can use accept/dismiss
    dismiss_confirm 'Do you confirm action?' do
      find(:css,"#confirmButton").click
    end
    sleep 5
  end

  it 'Handle Prompt box Tests' do
    visit "https://demoqa.com/alerts"
    # can use accept/dismiss
    message=accept_prompt("Please enter your name",with: "vikas saini") do
      find(:css,"#promtButton").click
    end
    puts "Returned message: #{message}"
    expect(message).to eql("Please enter your name")
    sleep 5

  end
end
