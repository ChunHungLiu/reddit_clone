class PostsController < ApplicationController
	
	before_action :find_post, only: [:show, :update, :edit, :destroy, :upvote]

	def index
		@posts = Post.all
	end

	def show

	end

	def create
		@post = Post.new(params[:post].permit(:title,:body))
		@post.votes = 0;
		@post.user_id = current_user.id
		@post.save
		
		redirect_to root_url
	end

	def new
		@post = Post.new
	end

	def update
		@post.update_attributes!(params[:post].permit(:title,:body))
		redirect_to root_url
	end

	def edit

	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	def upvote

		#if (current_user.votes.find_by(:post_id) == @post.id) == nil

		if (current_user.votes.find_by(:post_id => @post.id) == nil)
			@post.votes += 1
			@vote = Vote.new
			@vote.upvote = true;
			@vote.post_id = @post.id
			@vote.user_id = current_user.id
			@post.save
			@vote.save
		end
		#end
		redirect_to root_path
	end

	private

	def find_post 
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title,:body)
	end
end
