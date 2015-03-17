class PostsController < ApplicationController
  before_action :get_post, only: [:edit, :update, :show]
  
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    
    if @post.save
      flash[:notice] = "Your post was successfully created."
      redirect_to posts_path
    else
      render 'new'
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
    params.require(:post).permit(:title, :url, :description)
  end
  
  def get_post
    @post = Post.find(params[:id])
  end
  
end
