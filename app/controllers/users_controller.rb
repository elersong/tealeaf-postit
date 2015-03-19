class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "#{params[:user][:username]} was successfully registered!"
      session[:user_id] = User.find_by_username(params[:user][:username]).id
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
end