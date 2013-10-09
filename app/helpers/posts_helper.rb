module PostsHelper
	def item_comments(item)
		if item.is_a?Post
			item.comments.where(comment_id: nil)
		elsif item.is_a?Comment
			if item.comments
				item.comments
			else
				false
			end
		else
			raise 'error'
		end
	end
end
