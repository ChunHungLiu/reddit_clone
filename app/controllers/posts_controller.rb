class PostsController < ApplicationController
	
	before_action :find_post, only: [:show, :update, :edit, :destroy, :upvote, :downvote, :sidevote]

	before_action :find_vote, only: [:upvote, :downvote, :sidevote]

	def index
		@posts = Post.order(:votes).reverse

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

		if @vote == nil
			@vote = Vote.new
			@vote.post_id = @post.id
			@vote.user_id = current_user.id
		end

		if vote_is_new(@vote)
			@post.votes += 1
			@vote.upvote = true
		elsif @vote.upvote == false
			@post.votes += 2
			@vote.upvote = true			
		end

		@post.save
		@vote.save

		redirect_to root_path
	end

	def downvote

		if @vote == nil
			@vote = Vote.new
			@vote.post_id = @post.id
			@vote.user_id = current_user.id
		end

		if vote_is_new(@vote)
			@post.votes -= 1
			@vote.upvote = false	
		elsif @vote.upvote == true
			@post.votes -= 2
			@vote.upvote = false			
		end

		@post.save
		@vote.save

		redirect_to root_path
	end

	def sidevote
		if @vote == nil
			@vote.destroy
		else
			if @vote.upvote
				@post.votes -= 1
			elsif @vote.upvote == false
				@post.votes += 1
			end
			@post.save
			@vote.destroy
		end

		redirect_to root_path
	end

	private

	def find_vote
		@vote = current_user.votes.find_by(:post_id => @post.id)
	end

	def vote_is_new(vote)
		if vote.upvote == nil
			true
		else
			false
		end
	end

	def find_post 
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title,:body)
	end
end
