module Goodreads
	module Series
		
		#See a series
		#
		def show_series(id, oauth = true)
			options = {}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/series/show/#{id}.xml", options)
			else
				data = request("/series/show/#{id}.xml")
			end
			Hashie::Mash.new(data)
		end
		
		#See all series by an author
		#
		def show_series_by_author(author_id, oauth = true)
			options = {"id" => author_id}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/series/list", options)
			else
				data = request("/series/list", options)
			end
			Hashie::Mash.new(data)
		end
		
		#See all series a work is in
		#
		def work_series(work_id, oauth = true)
			options = {}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/series/work/#{work_id}", options)
			else
				data = request("/series/work/#{work_id}")
			end
			Hashie::Mash.new(data)
		end
		
	end
end