module Goodreads
	module Recommendations
		
		#Get a recommendation from a user to another user - Note: this is OAuth only
		#
		def get_recommendation(id)
			data = oauth_request("/recommendations/#{id}")
			Hashie::Mash.new(data)
		end
	end
end
