require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest

	test "user should see home page" do
		get "/"
		assert_equal 200, status
		assert_select 'h1', 'Aberdeen Registers'
	end

	test "user should see login page" do
		get "/sign_in"
		assert_equal 200, status
	end

	test "user should be able sign_up" do
  		get "/users/sign_up"
		assert_equal 200, status
		post "/users", params:{ user: {email: 'user@test.com', password: 'password', password_confirmation: 'password'} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Welcome! You have signed up successfully.'
	end

	test "user should be able to login" do
		@user = User.create(email: 'user@test.com', password: 'password', password_confirmation: 'password')
  		get "/users/sign_in"
		assert_equal 200, status
		post "/users/sign_in", params:{ user: {email: @user.email, password: @user.password} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Signed in successfully.'
	end

	test "user should be able to edit password" do
		@user = User.create(email: 'user@test.com', password: 'password', password_confirmation: 'password')
  		get "/users/sign_in"
		assert_equal 200, status
		post "/users/sign_in", params:{ user: {email: @user.email, password: @user.password} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Signed in successfully.'
		get "/users/edit"
		assert_equal 200, status
		put "/users", params:{ user: {email: @user.email, password: 'password2', 
			password_confirmation: 'password2', current_password: @user.password} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Your account has been updated successfully.'
	end

	test "user should not be able to edit password without confirmation" do
		@user = User.create(email: 'user@test.com', password: 'password', password_confirmation: 'password')
  		get "/users/sign_in"
		assert_equal 200, status
		post "/users/sign_in", params:{ user: {email: @user.email, password: @user.password} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Signed in successfully.'
		get "/users/edit"
		assert_equal 200, status
		put "/users", params:{ user: {email: @user.email, password: 'password2', 
			password_confirmation: 'password', current_password: @user.password} }
		assert_equal 200, status
		assert_equal "/users", path
		assert_select 'li', 'Password confirmation doesn\'t match Password'
	end

	test "user should not be able to edit password with invalid current password" do
		@user = User.create(email: 'user@test.com', password: 'password', password_confirmation: 'password')
  		get "/users/sign_in"
		assert_equal 200, status
		post "/users/sign_in", params:{ user: {email: @user.email, password: @user.password} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Signed in successfully.'
		get "/users/edit"
		assert_equal 200, status
		put "/users", params:{ user: {email: @user.email, password: 'password2', 
			password_confirmation: 'password2', current_password: 'password3'} }
		assert_equal 200, status
		assert_equal "/users", path
		assert_select 'li', 'Current password is invalid'
	end


	test "user should be able to edit email" do
		@user = User.create(email: 'user@test.com', password: 'password', password_confirmation: 'password')
  		get "/users/sign_in"
		assert_equal 200, status
		post "/users/sign_in", params:{ user: {email: @user.email, password: @user.password} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Signed in successfully.'
		get "/users/edit"
		assert_equal 200, status
		put "/users", params:{ user: {email: 'user1@test.com', password: '', 
			password_confirmation: '', current_password: @user.password} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Your account has been updated successfully.'
	end

	test "user should not be able to edit email if already registered" do
		@user = User.create(email: 'user@test.com', password: 'password', password_confirmation: 'password')
		@user1 = User.create(email: 'user1@test.com', password: 'password', password_confirmation: 'password')
  		get "/users/sign_in"
		assert_equal 200, status
		post "/users/sign_in", params:{ user: {email: @user.email, password: @user.password} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Signed in successfully.'
		get "/users/edit"
		assert_equal 200, status
		put "/users", params:{ user: {email: @user1.email, password: '', 
			password_confirmation: '', current_password: @user.password} }
		assert_equal 200, status
		assert_equal "/users", path
		assert_select 'li', 'Email has already been taken'
	end

	test "user should be able to sign out" do
		@user = User.create(email: 'user@test.com', password: 'password', password_confirmation: 'password')
  		get "/users/sign_in"
		assert_equal 200, status
		post "/users/sign_in", params:{ user: {email: @user.email, password: @user.password} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Signed in successfully.'
		delete "/users/sign_out"
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Signed out successfully.'
	end

	test "user should be able to destroy the account" do
		@user = User.create(email: 'user@test.com', password: 'password', password_confirmation: 'password')
  		get "/users/sign_in"
		assert_equal 200, status
		post "/users/sign_in", params:{ user: {email: @user.email, password: @user.password} }
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Signed in successfully.'
		delete "/users"
		follow_redirect!
		assert_equal 200, status
		assert_equal "/", path
		assert_select 'p', 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
	end

	#this is not user_controller_test
	test "user should not see document upload page" do
		get "/doc/new"
		assert_equal 302, status
		follow_redirect!
		assert_equal "/users/sign_in", path
		assert_equal 200, status
	end

end
