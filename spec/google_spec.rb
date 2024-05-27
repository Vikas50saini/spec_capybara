require 'spec_helper'
require 'capybara/dsl'

RSpec.describe 'Google Search', type: :feature do
  include Capybara::DSL

  it 'searches for a term' do
    visit 'https://www.google.com/'

    # Fill in the search field with a search term
    fill_in 'q', with: 'capybara rspec selenium'

    # Click the search button
    click_button 'Google Search'

    # Check if the search results page contains the search term
    expect(page).to have_content('capybara rspec selenium')
  end
end
