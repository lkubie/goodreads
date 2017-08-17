module Goodreads
	module Books
		# Search for books
		#
		# query   - Text to match against book title, author, and ISBN fields.
		# options - Optional search parameters
		#
		# page - Which page to returns (default: 1)
		# field - Search field. One of: title, author, or genre (default is all)
		#
		def search_books(query, page = 1, field = "all", oauth = true)
			if field != "title" && field != "author"  && field != "all"
				puts "NOTICE: Field value was not valid. Rolling back to 'all' default"
				field = "all"
			end
			options = {"q" => URI.encode(query.to_s.strip), "page" => page, "search[field]" => field}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/search/index", options)
			else
				data = request("/search/index", options)
			end
			
			Hashie::Mash.new(data["search"])
		end

		# Get book details by Goodreads book ID
		#
		def book(id, text_only = false, rating = nil, oauth = true)
			# text_only: Only show reviews that have text (default false)
			#rating: Show only reviews with a particular rating (optional)
			options = {"id" => id}
			if !rating.nil?
				options.merge!(rating: rating)
			end
			if text_only
				options.merge!(text_only: "true")
			end
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/book/show.xml", options)
			else
				data = request("/book/show.xml", options)
			end		
			Hashie::Mash.new(data["book"])
			puts "IN BOOK FUNCTION"
			puts data
		end

		# Get book details by book ISBN
		#
		def book_by_isbn(isbn, oauth = true)
			#isbn can be singular or multiple seperated by commas. ex: "111111111,2222222222,3333333333"
			options = {"isbn" => isbn}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/book/isbn", options)
			else
				data = request("/book/isbn", options)
			end	
			Hashie::Mash.new(data["book"])
		end

		# Get book details by book title
		#
		def book_by_title(title, author = nil, rating = nil, oauth = true)
			#Author: The author name of the book to lookup. This is optional, but is recommended for accuracy.
			#Rating: Show only reviews with a particular rating (optional)
			options = {"title" => title}
			if !author.nil?
				options.merge!(author: author)
			end
			if !rating.nil?
				options.merge!(rating: rating)
			end
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/book/title", options)
			else
				data = request("/book/title.xml", options)
			end
			Hashie::Mash.new(data["book"])
		end
	
		#Get Goodreads work id for a given book ID 
		#
		def get_work_id(book_id_list, oauth = true)
			options = {"id" => book_id_list}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/book/id_to_work_id", options)
			else
				data = request("/book/id_to_work_id", options)
			end
			#puts data
			Hashie::Mash.new(data)
		end
	
		#Get Review Statistics given a list of ISBNs
		#
		def get_review_statistics_from_isbn(isbns, oauth = true)
			#isbns can be a single isbn or a string of isbns seperated by commas ex: "111111111,2222222222,3333333333"
			options = {"isbns"=> isbns}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/book/review_counts.json", options)
			else
				data = request("/book/review_counts.json", options)
			end
			Hashie::Mash.new(data)
		end
		
		#Comapre books with another user - NOTE: This requires OAuth
		#
		def compare_books(id)
			options = {"id" => id}
			data = oauth_request("/user/compare/1.xml", options)
			Hashie::Mash.new(data)
		end
		
		#Get all editions by work - NOTE: this current requires extra permissions, and I have not tested it.
		#
		def editions_by_work(work_id, oauth = true)
			options = {}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/work/editions/#{work_id}", options)
			else
				data = request("/work/editions/#{work_id}", options)
			end
			Hashie::Mash.new(data)
		end

		
	end
end
