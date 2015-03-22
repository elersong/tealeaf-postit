class PostsController < ApplicationController
  before_action :get_post, only: [:edit, :update, :show, :vote]
  
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
  
  def vote
    vote = @post.votes.new(creator: current_user, vote: params[:vote])
    
    if current_user?
      # -------------------- Only run this block if user is logged in
      if vote.save
        flash[:notice] = "Your vote was successfully registered."
        redirect_to :back # there's no view, so take the user back
      else
        flash[:error] = "Your vote was not counted. Note that you may only vote once."
        redirect_to :back
      end
      # --------------------
    else
      flash[:error] = "You must be logged in to vote."
      redirect_to :back
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
