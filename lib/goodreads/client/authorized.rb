module Goodreads
	module Authorized
		#Get the Goodreads user ID of the OAuther user. - Note: this requires OAuth
		#
		def user_id()
			data = oauth_request("/api/auth_user")
			
		end
		
		#See current Goodreads Notifications. Note, this will mark them as seen
		#
		def notifications(page = 1)
			options = {"page" => page}
			data = oauth_request("/notifications.xml", options)
			puts "TESTING HERE"
			puts "raw"
			puts data
			puts "as JSON"
			puts data.to_json
			puts "Notifications"
			puts data['notifications']
			puts "Notifications HAshie"
			Hashie::Mash.new(data["notifications"])
			return data
		end
	end
end
