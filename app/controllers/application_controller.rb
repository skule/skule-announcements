class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :admin_logged_in?

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_logged_in?
  	if session[:user_id]
  		user = User.find(session[:user_id])
  		return user && user.is_admin
  	end

  	return false
  end

end
