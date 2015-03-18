class SessionsController < ApplicationController
  
  def create
    binding.pry
    user = User.find_by_username(params[:username])
    
    if user && user.authenticate(params[:password])
      #session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.username}"
      redirect_to root_path
    else
      flash.now.error = "Either your username or password was incorrect."
      redirect_to '/login'
    end
  end
  
  def destroy
    # remove user from session and redirect to home page
  end
  
  def new
  end
  
end