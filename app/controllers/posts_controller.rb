class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def show

	end

	def create
		@post = Post.new
		@post.update_attributes!(params[:post].permit(:title,:body))
		redirect_to root_url
	end

	def new
		@post = Post.new
	end

	def update

	end

	def edit

	end

	def destroy

	end

	private

	def post_params
		params.require(:post).permit(:title,:body)
	end
end
