module Goodreads
	module Listopia
		def get_listopia(book_id, oauth = true)
			options = {}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/list/book/#{book_id}.xml", options)
			else
				data = request("/list/book/#{book_id}.xml", options)
			end
			Hashie::Mash.new(data)
		end
	end
end