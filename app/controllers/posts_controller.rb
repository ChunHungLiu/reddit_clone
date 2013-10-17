class PostsController < ApplicationController
	
	before_action :find_post, only: [:show, :update, :edit, :destroy]
	before_action :find_vote, only: :show

	def index
		@posts = Post.order(:votes).reverse
		@votes = {}
		if current_user
			@posts.each do |post|
				@votes[post.id] = current_user.votes.find_by({item_id: post.id, item_type: 'post'})
			end
		end
	end

	def show

	end

	def create
		@post = Post.new(params[:post].permit(:title,:body))
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


	private



	def find_post 
		@post = Post.find(params[:id])
	end

	def find_vote
		if current_user
			@vote = current_user.votes.find_by(item_id: @post.id, item_type: 'post')
		end
	end	

	def post_params
		params.require(:post).permit(:title,:body)
	end
end
