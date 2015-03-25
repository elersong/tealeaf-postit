class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :not_profile
  
  def current_user?
    !!current_user
  end
  
  def current_user
    if session[:user_id] != nil
      @logged_in_user ||= User.find(session[:user_id])
    else
      nil
    end
  end
  
  def not_profile
    session[:profile_page] = false
  end
  
  def verify_admin(error)
    if !current_user.admin?
      flash[:error] = error
      redirect_to root_path
    end
  end
  
end
