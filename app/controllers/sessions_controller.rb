class SessionsController < ApplicationController
  
  def create
    user = User.find_by_username(params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.username}"
      redirect_to root_path
    else
      flash[:error] = "Either your username or password was incorrect."
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
  
  def new
    # don't allow a user to sign in while another user is already signed in
    if current_user?
      flash[:notice] = "You are already signed in as #{current_user.username}"
      redirect_to root_path
    end
  end
  
end