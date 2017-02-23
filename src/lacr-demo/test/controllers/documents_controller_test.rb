require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
	
	test "should get documents index" do
		get "/doc"
		assert_response :success
	end

end
