class CommentsController < ApplicationController
  def index

  end

  def show
  end

  def new
  	@post = Post.find(params[:post_id]) 
  	@comment = Comment.new
  end

  def create
  	@post = Post.find(params[:post_id]) 
  	@comment = @post.comments.build(params[:comment].permit(:body))
  	@comment.user_id = current_user.id
  	@comment.post_id = params[:post_id]
  	@comment.save
  	redirect_to @post
  end

  def edit
  end
end
