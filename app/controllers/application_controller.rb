class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :admin_logged_in?
  helper_method :verify_is_user
  helper_method :verify_is_admin

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

  def verify_is_user
    (current_user.nil?) ? redirect_to(root_path) : true
  end

  def verify_is_admin
    (admin_logged_in?) ? true : redirect_to(root_path)
  end

end
