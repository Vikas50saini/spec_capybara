require 'spec_helper'
require 'capybara/dsl'

RSpec.describe 'Rspec structure demo', type: :feature do
  include Capybara::DSL

  # Let (Lazy evaluation) - Calculated only once per test example
  let(:alert_message) { 'You clicked a button' }
  let(:confirmation_message) { 'Do you confirm action?' }
  let(:prompt_message) { "Please enter your name" }

  before(:all) do
    puts "Test Suite execution started....."
  end

  before(:each) do
    puts "Text execution started......"
    visit "https://demoqa.com/alerts"
  end

  after(:each) do
    page.quit
    puts "Text execution ended......"
  end

  after(:all) do
    puts "Test Suite execution ended....."
  end

  context "Handle Alert Scenario" do
    it 'Handle Alerts Tests' do
      accept_alert alert_message do
        sleep 2
        find(:css,"#alertButton").click
        sleep 5
      end
      sleep 5
    end

    it 'Handle Alerts that visible after 5 sec Tests' do
      accept_alert 'This alert appeared after 5 seconds' do
        sleep 8
        find(:css,"#timerAlertButton").click
        sleep 8
      end
      sleep 5
    end
  end

  context "Handle Confirm and promt box scenario" do
    it 'Handle Confirm box Tests' do
      # can use accept/dismiss
      dismiss_confirm confirmation_message do
        find(:css,"#confirmButton").click
      end
      sleep 5
    end

    it 'Handle Prompt box Tests' do
      # can use accept/dismiss
      message=accept_prompt(prompt_message,with: "vikas saini") do
        find(:css,"#promtButton").click
      end
      puts "Returned message: #{message}"
      expect(message).to eql(prompt_message)
      sleep 5
    end
  end
end
