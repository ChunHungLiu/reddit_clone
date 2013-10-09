class CommentsController < ApplicationController

  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :find_post, only: [:new, :create, :update, :edit, :destroy]

  def index

  end

  def show

  end

  def new
  	@comment = Comment.new
    @comment_id = params[:comment_id]
  end

  def create
  	@comment = @post.comments.build(params[:comment].permit(:body))
  	@comment.user_id = current_user.id
    # if there is a comment then add that too
    if params[:comment_id]
      @comment.comment_id = params[:comment_id]
    end
  	@comment.save
  	redirect_to @post
  end

  def edit

  end

  def update
  	@comment.update_attributes!(params[:comment].permit(:body))
  	@comment.save
  	redirect_to @post
  end

  def destroy
  	@comment.destroy
  	redirect_to @post
  end

  private

  def find_comment
  	@comment = Comment.find(params[:id])
  end

  def find_post
  	@post = Post.find(params[:post_id])
  end
end
