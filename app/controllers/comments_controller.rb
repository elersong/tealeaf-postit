class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    
    if current_user?
      @comment.creator = current_user
      
      # only allow comments if the user is signed in
      if @comment.save
        flash[:notice] = "Your comment was successfully submitted."
        redirect_to post_path(@post)
      else
        render 'posts/show'
      end
      
    # user isn't signed in. redirect to login
    else
      flash[:error] = "You must be logged in to leave a comment."
      redirect_to login_path
    end
  end
  
  def vote
    @comment = Comment.find(params[:id])
    vote = @comment.votes.new(creator: current_user, vote: params[:vote])
    
    if vote.save
      flash[:notice] = "Your vote was successfully registered."
      redirect_to :back # there's no view, so take the user back
    else
      flash[:error] = "Your vote was not counted."
      redirect_to :back
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end