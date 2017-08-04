module Goodreads
	module OwnedBooks
		#NOTE: all of these functions require OAuth
		
		#Add a book to owned books
		#
		def add_owned(book_id, condition = nil, condition_description = nil, original_purchase_date = nil, original_purchase_location = nil, bcid = nil)
			options = {"owned_book[book_id]" => book_id}
			if !condition.nil?
				options["owned_book[condition_code]"] = condition
			end
			if !condition_description.nil?
				options["owned_book[condition_description]"] = condition_description
			end
			if !original_purchase_date.nil?
				options["owned_book[original_purchase_date]"] = original_purchase_date
			end
			if !original_purchase_location.nil?
				options["owned_book[original_purchase_location]"] = original_purchase_location
			end
			if !bcid.nil?
				options["owned_book[unique_code]"] = bcid
			end
			data = oauth_request("/owned_books.xml", options, "post")
		end
		
		#Get a list of a user's owned books
		#
		def list_owned(id, page = 1)
			options = {"id" => id, "page" => page}
			data = oauth_request("/owned_books/user", options)
			Hashie::Mash.new(data)
		end
		
		#Show an owned book
		#
		def show_owned(book_record_id)
			data = oauth_request("/owned_books/show/#{book_record_id}")
			Hashie::Mash.new(data)
		end
		
		#Update an owned book
		#
		def update_owned(book_record_id, book_id, condition = nil, condition_description = nil, original_purchase_date = nil, original_purchase_location = nil, bcid = nil)
			options = {"owned_book[book_id]" => book_id}
			if !condition.nil?
				options["owned_book[condition_code]"] = condition
			end
			if !condition_description.nil?
				options["owned_book[condition_description]"] = condition_description
			end
			if !original_purchase_date.nil?
				options["owned_book[original_purchase_date]"] = original_purchase_date
			end
			if !original_purchase_location.nil?
				options["owned_book[original_purchase_location]"] = original_purchase_location
			end
			if !bcid.nil?
				options["owned_book[unique_code]"] = bcid
			end
			data = oauth_request("/owned_books/update/#{book_record_id}", options, "put")
			Hashie::Mash.new(data)
		end
		
		#Delete an owned book
		#
		def delete_owned(book_record_id)
			data = oauth_request("/owned_books/destroy/#{book_record_id}", {}, "post")
		end
		
	end
end