class VotesController < ApplicationController

	before_action :find_item
	before_action :find_vote


	def upvote

		if @vote == nil
			@vote = Vote.new
			@vote.item_id = @item.id
			@vote.user_id = current_user.id
		end

		if vote_is_new(@vote)
			@item.votes += 1
			@vote.upvote = true
		elsif @vote.upvote == false
			@item.votes += 2
			@vote.upvote = true			
		end

		@item.save
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
		if params[:type] == 'post'
			@item = Post.find(params[:id])
		elsif params[:type] == 'comment'
			@item = Comment.find(params[:id])
		else
			throw 'error'
		end
	end

	def find_vote
		if @item.is_a?Post
			@vote = current_user.votes.find_by(:item_id => @item.id, type: 'post')
		elsif @item.is_a?Comment
			@vote = current_user.votes.find_by(:item_id => @item.id, type: 'comment')
		end
	end

	def vote_is_new(vote)
		if vote.upvote == nil
			true
		else
			false
		end
	end

end
