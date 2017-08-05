module Goodreads
	module Friends
		# Get the specified user's friends -NOTE: this is an OAuth only call
		#
		# user_id - integer or string
		#
		def friends(user_id, page = 1, sort = "first_name")
			if !["first_name", "date_added", "last_online"].include(sort)
				puts "ERROR: Invalid sort parameter passes"
			else
				options = {"id" => user_id, "page" => page, "sort" => sort}
				data = oauth_request("/friend/user.xml")
				Hashie::Mash.new(data["friends"])
			end
		end
		
		
		# Confirm or Reject a Friend Recomendation - Note: requires OAuth
		# Not sure how to list all the recommendations right now...
		#
		def respond_friend_recommendation(recommendation_id, response)
			#response must be either "Y" or "N"
			options = {"id" => recommendation_id, "response" => response}
			case response
			when "Y","N"
				data = oauth_request("/friend/confirm_recommendation.xml", options, "post")
			else
				puts "responce must be either Y or N, you entered: #{response}"
			end
		end
	
		# Confirm or Reject a Friend Request - Note: requires OAuth
		#
		def respond_friend_request(friend_request_id, response)
			#response must be either "Y" or "N"
			options = {"id" => friend_request_id, "response" => response}
			case response
			when "Y","N"
				data = oauth_request("/friend/confirm_request.xml", options, "post")
			else
				puts "responce must be either Y or N, you entered: #{response}"
			end
		end
	
		# Lists Friend Requests - Note: requires OAuth
		#
		def friend_requests(page = 1)
			options = {"page" => page}
			data = oauth_request("/friend/requests.xml", options)
			Hashie::Mash.new(data)
		end
	
		#Adds a goodreads friend - Note: requires OAuth
		#
		def add_friend(id)
			#Goodreads ID of the member you'd like to befriend
			options = {"id" => id}
			data = oauth_request("/friend/add_as_friend.xml", options, "post")
		end
		
		#Get your friend updates - NOTE: this is OAuth only
		#
		def friends_updates(update = "all", update_filter = "friends", max_updates = "20")
			if !["books", "reviews", "statuses", "all"].include?(update)
				puts "ERROR: invalid update value entered!"
			elsif !["friends", "following", "top_friends"].include?(update_filter)
				puts "ERROR: invalid update_filter entered!"
			else
				options = {"update" => update, "update_filter" => update_filter, "max_updates" => max_updates}
				data = oauth_request("/updates/friends.xml", options)
			end
		end
	
	
	
	
	end
end
