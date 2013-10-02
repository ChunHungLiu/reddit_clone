class CommentsController < ApplicationController

  before_action :find_comment, only: [:edit, :update]
  before_action :find_post, only: [:new, :create, :update, :edit]

  def index

  end

  def show

  end

  def new
  	@comment = Comment.new
  end

  def create
  	@comment = @post.comments.build(params[:comment].permit(:body))
  	@comment.user_id = current_user.id
  	@comment.post_id = params[:post_id]
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

  private

  def find_comment
  	@comment = Comment.find(params[:id])
  end

  def find_post
  	@post = Post.find(params[:post_id])
  end
end
