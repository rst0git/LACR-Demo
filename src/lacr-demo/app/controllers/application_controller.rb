class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def user_exist?
    unless User.where(["email_address = :email_address and id = :id", { email_address: session[:email_address], id: session[:user_id] }]).blank?
      true
    else
      false
    end
  end    

  helper_method :user_exist?
  
end
