class VotesController < ApplicationController

	before_action :find_post
	before_action :find_comment
	before_action :find_vote

	def upvote
		
		if @comment.nil?
			@item = @post
		else
			@item = @comment
		end

		if @vote.nil?
			@vote = Vote.new
			@vote.item_id = @item.id
			@vote.item_type = item_type(@item)
			@vote.user_id = current_user.id
		end

		if @vote.upvote.nil?
			@item.votes += 1
			@vote.upvote = true
		elsif @vote.upvote == false
			@item.votes += 2
			@vote.upvote = true
		end

		@item.save
		@vote.save

		if item_type(@item) == 'comment'
			redirect_to post_path(@post)
		else
			redirect_to root_path
		end
	end

	def downvote

		if @comment.nil?
			@item = @post
		else
			@item = @comment
		end

		if @vote == nil
			@vote = Vote.new
			@vote.item_id = @item.id
			@vote.item_type = item_type(@item)
			@vote.user_id = current_user.id
		end

		if @vote.upvote.nil?
			@item.votes -= 1
			@vote.upvote = false	
		elsif @vote.upvote == true
			@item.votes -= 2
			@vote.upvote = false			
		end

		@item.save
		@vote.save

		if item_type(@item) == 'comment'
			redirect_to post_path(@post)
		else
			redirect_to root_path
		end
	end

	def sidevote

		if @comment.nil?
			@item = @post
		else
			@item = @comment
		end
		
		if @vote.upvote
			@item.votes -= 1
		elsif @vote.upvote == false
			@item.votes += 1
		end
		@item.save
		@vote.destroy

		if item_type(@item) == 'comment'
			redirect_to post_path(@post)
		else
			redirect_to root_path
		end
	end

	private

	def find_post
		@post = Post.find(params[:post_id])
	end

	def find_comment
		unless params[:comment_id].nil?
			@comment = Comment.find(params[:comment_id])
		end
	end

	def find_vote
		if @comment.nil?
			@vote = current_user.votes.find_by(:item_id => @post.id, item_type: 'post')
		else
			@vote = current_user.votes.find_by(:item_id => @comment.id, item_type: 'comment')
		end
	end

	def item_type(item)
		if @comment.nil?
			return 'post'
		else
			return 'comment'
		end
	end

end
