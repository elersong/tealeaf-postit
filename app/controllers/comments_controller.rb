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
    
    respond_to do |format| 
      
      format.html do
        if current_user?
          # -------------------- Only run this block if user is logged in
          if vote.save
            redirect_to :back, notice: "Your vote was successfully registered."
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
      
      format.js do
        if current_user?
          if vote.save
            flash[:notice] = "Your vote was successfully registered."
          else
            flash[:error] = "Your vote was not counted. Note that you may only vote once." 
          end
        else
          flash[:error] = "You must be logged into vote." 
        end
      end
    
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end