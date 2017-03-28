require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
	
	test "should get documents index" do
		get "/doc"
		assert_response :success
	end

	test "user should not see document upload page" do
		get "/doc/new"
		assert_equal 302, status
		follow_redirect!
		assert_equal "/users/sign_in", path
		assert_equal 200, status
	end

end
