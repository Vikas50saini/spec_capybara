require 'spec_helper'
require 'capybara/dsl'

RSpec.describe "Form Practice" do
  include Capybara::DSL
  before(:each) do
    visit "https://demoqa.com/automation-practice-form"
  end
  context "Fill the form" do
    it "FIll form tests" do
      fill_in "First Name", with: "John"
      fill_in "Last Name", with: "Doe"
      fill_in "userEmail", with: "johndoe@example.com"
      find(:xpath, "//label[text()='Male']").click
      find(:css,"#userNumber").set("8076773421")
      within(:xpath, "//*[@id='dateOfBirth-wrapper']") do
        find(:css, "#dateOfBirthInput").click
        month = find(:css, ".react-datepicker__month-select")
        month.find("option[value='5']").select_option
        year = find(:css, ".react-datepicker__year-select")
        year.find("option[value='1994']").select_option
        date = find(:xpath, "(//*[@class='react-datepicker__month'] //div[@role='option' and text()='5'])[1]")
        date.click
        sleep(5)
      end
      hobbies=all("#hobbiesWrapper label[for*='hobbies-checkbox']")
      hobbies.each do |hobby|
        hobby.click
      end
      attach_file("Select picture","IMAGE.png")
      #div[id*='react-select-3-option']
      find(:xpath,"//*[text()='Select State']").click
      find(:css,"div[id*='react-select-3-option']:nth-of-type(2)").click
      find(:xpath,"//*[text()='Select City']").click
      find(:css,"div[id*='react-select-4-option']:nth-of-type(2)").click
      find(:css,"#submit").click
      sleep(5)
    end
  end
  context "Querying" do

    it "Querying: checking elements presence" do
      has_name=page.has_css?("#firstName")
      puts "is name css there: #{has_name}"
      expect(has_name).to eq(true)

      has_email=page.has_xpath?("//*[@id='userEmail']")
      expect(has_email).to eq(true)
      puts "is email xpath there: #{has_email}"

      email_text_present = find(:css, "#userEmail-label").has_text?("Email")
      expect(email_text_present).to eq(true)
      puts "is email text present here: #{email_text_present}"
    end

    it "Querying: checking elements presence using expect assertion" do
      expect(page.current_url).to include("practice-form")
      expect(page).to have_css("#firstName")
      expect(page).to have_xpath("//*[@id='userEmail']")
      expect(find(:css, "#userEmail-label")).to have_text("Email")
    end
  end
end

