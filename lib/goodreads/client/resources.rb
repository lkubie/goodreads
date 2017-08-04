module Goodreads
	module Resources
		#NOTE: All of these functions are OAuth only
		
		$resource_types = ["Comment", "EventResponse", "Friend", "GroupRequest", "List", "Message", "Poll", "Question", "Quiz", "Quote", "Rating", "Recommendation", "Review", "User", "UserStatus", "UserFollowing", "WishListBook"]
		
		#Like a resource
		#
		def like_resource( resource_id, resource_type)
			if $resource_types.include?(resource_type)
				options = {"rating[rating]" => "1", "rating[resource_id]" => resource_id, "rating[resource_type]" => resource_type}
				data = oauth_request("/rating", options, "post")
			else
				puts "ERROR: invalid resource type given. Cannot perform request"
			end
		end
		
		def unlike_resource(rating_id)
			options = {"id" => rating_id}
			data = oauth_request("/rating", options, "delete")
		end
	end
end