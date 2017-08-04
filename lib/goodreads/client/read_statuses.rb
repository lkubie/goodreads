module Goodreads
	module ReadStatuses
		#Get a particular read status
		#
		def get_read_status(id, oauth = true)
			options = {}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/read_statuses/#{id}", options)
			else
				data = request("/read_statuses/#{id}", options)
			end
			Hashie::Mash.new(data)
		end
	end
end