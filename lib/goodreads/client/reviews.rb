module Goodreads
	module Reviews
		# Recent reviews from all members.
		#
		# params[:skip_cropped] - Select only non-cropped reviews
		#
		def add_review(book_id, review_text = "", review_rating = 0, review_at = "")
			review = {}
			options = {}
			if review_at == ""
				# review["review"] = review_text
				#review["rating"] = review_rating
				options = {"book_id"=> book_id, "review[review]"=> CGI.escape(review_text), "review[rating]"=> review_rating}
			else
				# review["review"] = review_text
# 				review["rating"] = review_rating
# 				review["read_at"] = review_at
				#review[rating]=$rating&review[review]=$review
				options = {"book_id"=> book_id, "review[review]"=> CGI.escape(review_text), "review[read_at]"=> review_at, "review[rating]"=> review_rating}
			end
			data = oauth_request("/review.xml", options, "post")
		end
	
		def edit_review(review_id, review_text = "", review_rating = 0, finished = "true")
			puts "HERE"
			review = {}
			options = {}
			# review["review"] = review_text
			#review["rating"] = review_rating
			options = {"review[review]"=> CGI.escape(review_text), "review[rating]"=> review_rating, "finished"=> finished}
			data = oauth_request("/review/" + review_id + ".xml", options, "post")
		end
	
	
	
		def recent_reviews(params = {})
			skip_cropped = params.delete(:skip_cropped) || false
			data = request("/review/recent_reviews", params)
			return unless data["reviews"] && data["reviews"].key?("review")
			reviews = data["reviews"]["review"].map { |r| Hashie::Mash.new(r) }
			reviews = reviews.select { |r| !r.body.include?(r.url) } if skip_cropped
			reviews
		end

		# Get review details
		#
		def review(id)
			data = request("/review/show", id: id)
			Hashie::Mash.new(data["review"])
		end

		# Get list of reviews
		#
		def reviews(params = {})
			data = request("/review/list", params.merge(v: "2"))
			reviews = data["reviews"]["review"]
			if reviews.present?
				reviews.map { |review| Hashie::Mash.new(review) }
			else
				[]
			end
		end
	end
end
