class PostsController < ApplicationController
  before_action :get_post, only: [:edit, :update, :show]
  
  def index
    @posts = Post.all
  end
  
  def new
    # don't allow a user to sign in while another user is already signed in
    if current_user?
      @post = Post.new
    else
      flash[:error] = "You must be logged in to submit a post."
      redirect_to login_path
    end
  end
  
  def create
    @post = Post.new(post_params)
    
    if current_user?
      @post.creator = current_user
      
      # only allow posts if the user is signed in
      if @post.save
        flash[:notice] = "Your post was successfully created."
        redirect_to posts_path
      else
        render 'new'
      end
      
    # user isn't signed in. redirect to login
    else
      flash[:error] = "You must be logged in to submit a post."
      redirect_to login_path
    end
  end
  
  def show
    @comment = @post.comments.new
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was successfully updated."
      redirect_to posts_path
    else
      render 'edit'
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
  
  def get_post
    @post = Post.find(params[:id])
  end
  
end
