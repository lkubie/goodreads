module Goodreads
	module Statuses
		
		#Update a status - NOTE: this is OAuth only
		#
		def update_status(book_id = nil, page = nil, percent = nil, body = nil)
			options = {}
			if !book_id.nil?
				options["user_status[book_id]"] = book_id
			end
			if !page.nil?
				options["user_status[page]"] = page
			end
			if !percent.nil?
				options["user_status[percent]"] = percent
			end
			if !body.nil?
				options["user_status[body]"] = body
			end
			data = oauth_request("/user_status.xml", options, "post")
		end
		
		#Delete a status update. NOTE: Requires OAuth!
		#
		def delete_status(status_id)
			data = oauth_request("/user_status/destroy/#{status_id}", {}, "post")
		end
		
		def get_status(status_id, oauth = true)
			options = {}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/user_status/show/#{status_id}", options)
			else
				data = request("/user_status/show/#{status_id}", options)
			end
			Hashie::Mash.new(data)
		end
		
		def most_recent_statuses(oauth = true)
			options = {}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/user_status/index.xml", options)
			else
				data = request("/user_status/index.xml", options)
			end
			Hashie::Mash.new(data)
		end
		
	end
end