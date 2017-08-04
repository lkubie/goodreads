module Goodreads
  module Comments
	  #DEFINITIONS:
		# type: one of 'author_blog_post', 'author_following', 'blog', 'book_news_post', 'chapter', 'comment', 'community_answer', 'event_response', 'friend', 'giveaway', 'giveaway_request', 'group_user', 'interview', 'librarian_note', 'link_collection', 'list', 'owned_book', 'photo', 'poll', 'poll_vote', 'queued_item', 'question', 'question_user_stat', 'quiz', 'quiz_score', 'rating', 'read_status', 'recommendation', 'recommendation_request', 'review', 'review_proxy', 'services/models/reading_note', 'sharing', 'topic', 'user', 'user_challenge', 'user_following', 'user_list_challenge', 'user_list_vote', 'user_quote', 'user_status', 'video'
		# id: Id of resource given as type param
	  
	  
	  # Create a new comment on a resource -  note, this is OAuth only
	  #
	  def comment(id, type, comment)
		  #You need to register your app for this method
  		# comment: This is the text of your comment
		require 'uri'
		encoded_comment = URI.encode(comment)
  		options = {"id"=> id, "type"=> type, "comment[body]"=> encoded_comment}
  		data = oauth_request("/comment.xml", options, "post")
	  end
	  
	  # Gets comments for a resource
	  # 
		def get_comments(id, type, page = 1, oauth = true)
			options = {"id"=> id, "type"=> type, "page" => page}
			if oauth
				data = oauth_request("/comment.xml", options)
			else
				data = request("/comment.xml", options)
			end
			Hashie::Mash.new(data)
		end
	end
end