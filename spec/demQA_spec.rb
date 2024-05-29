require 'spec_helper'
require 'capybara/dsl'

RSpec.describe 'Google Search', type: :feature do
  include Capybara::DSL

  it 'Elements Text box Tests' do
    visit 'https://demoqa.com/'
    find(:xpath,"//div[@class='card-body']//h5[text()='Elements']").click
    find(:xpath,"//li[@id='item-0']//span[text()='Text Box']").click

    fill_in('userName', with: 'John')
    fill_in('userEmail', with: 'John@gmail.com')
    fill_in('currentAddress', with: 'Address1')
    fill_in('permanentAddress', with: 'Address1')
    click_button("submit")
    sleep 5
  end

  it 'Elements check box Tests' do
    visit 'https://demoqa.com/'
    find(:xpath,"//div[@class='card-body']//h5[text()='Elements']").click
    find(:xpath,"//li[@id='item-1']//span[text()='Check Box']").click

    find(:xpath,"//span[text()='Home']").click
    sleep 5
  end

  it 'Elements radio button Tests' do
    visit 'https://demoqa.com/'
    find(:xpath,"//div[@class='card-body']//h5[text()='Elements']").click
    find(:xpath,"//li[@id='item-2']//span[text()='Radio Button']").click

    find(:css,"label[for='impressiveRadio']").click
    sleep 5
  end

  it 'Elements Querying Tests' do
    visit 'https://demoqa.com/'
    find(:xpath,"//div[@class='card-body']//h5[text()='Elements']").click
    find(:xpath,"//li[@id='item-4']//span[text()='Buttons']").click

    if page.has_selector?("#doubleClickBtn")
        find(:css,"#doubleClickBtn").double_click
        expect(find(:css,"#doubleClickMessage")).to have_text 'You have done a double click'
    else
        puts "element not found"
    end
    if page.has_xpath?("//*[@id='rightClickBtn']")
        find(:xpath,"//*[@id='rightClickBtn']").right_click(:control)
        expect(find("#rightClickMessage")).to have_text 'You have done a right click'
    else
        puts "right click ele not found"
    end
    if page.has_css?("div:nth-of-type(1) button.btn.btn-primary")
        click_button("Click Me")
        is_text_found=page.has_content?("You have done a dynamic click")
        expect(is_text_found).to be true
    else
        puts "element not found"
    end
    sleep 5
  end
end
