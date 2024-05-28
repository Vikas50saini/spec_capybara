require 'spec_helper'
require 'capybara/dsl'

RSpec.describe 'Google Search', type: :feature do
  include Capybara::DSL

  it 'Execute java-script code Tests' do
    visit 'https://demoqa.com/buttons'
    button = find(:xpath,"//button[text()='Click Me']")
    page.execute_script("arguments[0].click()", button) # executing javascript code
    text= find(:xpath,"//p[text()='You have done a dynamic click']").text
    expect(text).to eql("You have done a dynamic click")
    sleep 5

    result = page.evaluate_script(<<~JS)
     (function(n){
      return n*n;
     })(#{3})
     JS
    puts result
  end
end
