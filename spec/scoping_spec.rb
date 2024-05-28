require 'spec_helper'
require 'capybara/dsl'

RSpec.describe 'Google Search', type: :feature do
  include Capybara::DSL

  it 'Elements Scoping Tests' do
    visit 'https://artoftesting.com/samplesiteforselenium'
    within("#commonWebElements>form:nth-of-type(1)") do
     find("#male").choose
    end
    within(:xpath,"//*[@id='commonWebElements']//p[text()='TextBox : ']") do
      fill_in("fname",with: "vikas") # can use id, name
    end
    sleep 5
  end
end
