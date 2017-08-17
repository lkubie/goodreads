module Goodreads
	module Users
		# Get user details
		#
		def user(id, oauth = true, options = {})
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/user/show/#{id}.xml")
			else
				data = request("/user/show/#{id}.xml")
			end
			Hashie::Mash.new(data["user"])
		end
	
	
		# Follow a user - Note: this is an OAuth *ONLY* call
		#
		def follow_user(id)
			options = {"format" => "xml"}
			data = oauth_request("/user/#{id}/followers", options, "post")
		end
	
		# Unfollow a user - Note: this is an OAuth *ONLY* call
		#
		def unfollow_user(id)
			options = {}
			data = oauth_request("/user/#{id}/followers/stop_following.xml", options, "delete")
		end
		
		# List all users currently following - Note: this is an OAuth *ONLY* call
		#
		def following(id, page = 1)
			options = {"page" => page}
			data = oauth_request("/user/#{id}/following.xml", options)
			Hashie::Mash.new(data)
		end
	
	end
end
