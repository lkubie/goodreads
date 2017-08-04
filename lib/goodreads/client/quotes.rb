module Goodreads
	module Quotes
		
		#Add a quote using OAuth. If you don't specify an author_id, it will try to look one up based on the author_name you 
		#
		def add_quote(author_name, quote, author_id = nil, book_id = nil, tags = nil, isbn = nil)
			options = {"quote[author_name]" => author_name, "quote[body]" => quote}
			if !author_id.nil?
				options["quote[author_id]"] = author_id
			end
			if !book_id.nil?
				options["quote[book_id]"] = book_id
			end
			if !tags.nil?
				options["quote[tags]"] = tags
			end
			if !isbn.nil?
				options["isbn"] = isbn
			end
			data = oauth_request("/quotes", options, "post")
		end
	end
end