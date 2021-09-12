require 'test_helper'

class PagesController::IndexTest < ActionController::TestCase
  def test_routes
    assert_routing '/', controller: "pages", action: "home"
    assert_routing '/result', controller: "pages", action: "result"
  end
end
