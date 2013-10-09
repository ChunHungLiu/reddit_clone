class VotesController < ApplicationController

	before_action :find_item
	before_action :find_vote


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
		if @vote.upvote
			@post.votes -= 1
		elsif @vote.upvote == false
			@post.votes += 1
		end
		@post.save
		@vote.destroy

		redirect_to root_path
	end

	private

	def find_item
		@post = Post.find(params[:id])
	end

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

end
