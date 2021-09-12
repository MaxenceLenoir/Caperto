require 'test_helper'

require "application_system_test_case"

class SearchFlowTest < ApplicationSystemTestCase
  def setup
    @paris = capitals :paris
    @madrid = capitals :madrid
  end

  test 'search only 1 capital out of 2' do
    visit root_url
    
    fill_in "search[latitude]", with: 48
    fill_in "search[longitude]", with: 0
    fill_in "search[radius]", with: 600

    click_on "Search"

    assert page.assert_selector('.capital', count: 1)
  end

  test 'search all capitals' do
    visit root_url
    
    fill_in "search[latitude]", with: 48
    fill_in "search[longitude]", with: 0
    fill_in "search[radius]", with: 1600

    click_on "Search"

    assert page.assert_selector('.capital', count: 2)
  end
end
