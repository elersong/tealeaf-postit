class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "#{params[:user][:username]} was successfully registered!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def show
    session[:profile_page] = true # this is a profile page, obviously
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    if User.find(current_user.id).update(user_params)
      flash[:notice] = "Your profile was successfully updated."
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end
  
  def get_user
    @user = User.find_by(slug: params[:id])
  end
  
end