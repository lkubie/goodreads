module Goodreads
	module Reviews
		
		#Add a new review. Note- this is OAuth-only
		#
		def add_review(book_id, review_text = "", review_rating = 0, review_at = "", shelf = nil)
			#review_at: Date (YYYY-MM-DD format, e.g. 2008-02-01) (optional)
			#review = {}
			#options = {}
			if review_at == ""
				options = {"book_id"=> book_id, "review[review]"=> CGI.escape(review_text), "review[rating]"=> review_rating}
			else
				options = {"book_id"=> book_id, "review[review]"=> CGI.escape(review_text), "review[read_at]"=> review_at, "review[rating]"=> review_rating}
			end
			if !shelf.nil?
				options.merge!(shelf: shelf)
			end
			data = oauth_request("/review.xml", options, "post")
		end
		
		#Edit an existing review. Note- this is OAuth-only
		#
		def edit_review(review_id, review_text = "", review_rating = 0, finished = "true", shelf = nil)
			#review = {}
			#options = {}
			options = {"review[review]"=> CGI.escape(review_text), "review[rating]"=> review_rating, "finished"=> finished}
			if !shelf.nil?
				options.merge!(shelf: shelf)
			end
			data = oauth_request("/review/#{review_id}.xml", options, "post")
		end
		
		#Delete an existing review. Note- this is OAuth-only
		#
		def delete_review(review_id)
			data = oauth_request("/review/#{review_id}.xml", {}, "delete")
		end
		
		#See revent reviews from all Goodreads' users
		#
		def recent_reviews(options = {}, oauth = true)
			skip_cropped = options.delete(:skip_cropped) || false
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/review/recent_reviews.xml", params)
			else
				data = request("/review/recent_reviews.xml", params)
			end	
			return unless data["reviews"] && data["reviews"].key?("review")
			reviews = data["reviews"]["review"].map { |r| Hashie::Mash.new(r) }
			reviews = reviews.select { |r| !r.body.include?(r.url) } if skip_cropped
			reviews
		end

		# Get review details
		#
		def review(id, page = 1, oauth = true)
			options = {"id" => id, "page" => page}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/review/show", options)
			else
				data = request("/review/show", options)
			end
			Hashie::Mash.new(data["review"])
		end

		#Get a user's review for a given book
		#
		def get_user_book_review(user_id, book_id, include_review_on_work = "false", oauth = true)
			options = {"user_id" => user_id, "book_id" => book_id, "include_review_on_work" => include_review_on_work}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/review/show_by_user_and_book.xml", options)
			else
				data = request("/review/show_by_user_and_book.xml", options)
			end
			Hashie::Mash.new(data)
		end
	end
end
