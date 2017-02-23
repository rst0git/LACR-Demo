require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "should get home page" do
    get "/"
    assert_response :success
    assert_select 'h1', 'Aberdeen Registers'
  end
  
  test "should get about" do
    get "/about"
    assert_response :success
  end

  test "should get contact" do
    get "/contact"
    assert_response :success
  end

end
