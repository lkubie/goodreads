module Goodreads
	module Users
		# Get user details - Note: you cannot use OAuth for this call.
		#
		def user(id, oauth = true)
			data = request("/user/show", id: id)
			Hashie::Mash.new(data["user"])
		end
	
	
		# Follow a user - Note: this is an OAuth *ONLY* call
		#
		def follow_user(id)
			options = {"format" => "xml"}
			data = oauth_request("/user/" + id.to_s + "/followers", options, "post")
		end
	
		# Unfollow a user - Note: this is an OAuth *ONLY* call
		#
		def unfollow_user(id)
			options = {}
			data = oauth_request("/user/" + id.to_s + "/followers/stop_following.xml", options, "delete")
		end
		
		def following(id, page = 1)
			options = {"page" => page}
			data = oauth_request("/user/" + id.to_s + "/following.xml", options)
			Hashie::Mash.new(data)
		end
	
	end
end
