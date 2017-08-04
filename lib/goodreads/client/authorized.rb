module Goodreads
	module Authorized
		#Get the Goodreads user ID of the OAuther user. - Note: this requires OAuth
		#
		def user_id
			oauth_request("/api/auth_user")["user"]["id"]
		end
		
		#See current Goodreads Notifications. Note, this will mark them as seen
		#
		def notifications(page = 1)
			options = {"page" => page}
			data = oauth_request("/notifications.xml", options)
			Hashie::Mash.new(data)
		end
	end
end
