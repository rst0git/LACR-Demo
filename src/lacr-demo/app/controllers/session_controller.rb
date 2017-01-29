#By Marcel Zak
class SessionController < ApplicationController
	def new
	end
  def create
  	if @current_user = User.authenticate(params[:email_address], params[:password])
		session[:user_id] = @current_user.id
		session[:first_name] = @current_user.first_name
		session[:email_address] = @current_user.email_address
		redirect_to root_url
	else
		redirect_to login_url, :alert => "Username or password is invalid"
	end
  end

  def destroy
  	session[:user_id] = nil
	@current_user = nil
  	redirect_to root_url
  end
end
