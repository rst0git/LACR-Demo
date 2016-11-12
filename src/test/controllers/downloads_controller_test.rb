require 'test_helper'

class DownloadsControllerTest < ActionDispatch::IntegrationTest
  test "should get zipped" do
    get downloads_zipped_url
    assert_response :success
  end

  test "should get img" do
    get downloads_img_url
    assert_response :success
  end

  test "should get trancr" do
    get downloads_trancr_url
    assert_response :success
  end

end
