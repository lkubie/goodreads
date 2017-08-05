module Goodreads
  module Shelves
    # Get books from a user's shelf
    def shelf(user_id, shelf_name, options = {}, oauth = true)
	  if shelf_name == ""
		  options = options.merge(v: 2)
	  else
		  options = options.merge(shelf: shelf_name, v: 2, key: api_key)
	  end
	  #puts "USER ID IN REQUEST: #{user_id}"
	  	if oauth
      		data = oauth_request("/review/list/#{user_id}", options)
		else
			data = request("/review/list/#{user_id}", options)
			
		end
      reviews = data["reviews"]["review"]

      books = []
      unless reviews.nil?
        # one-book results come back as a single hash
        reviews = [reviews] unless reviews.instance_of?(Array)
        books = reviews.map { |e| Hashie::Mash.new(e) }
      end

      Hashie::Mash.new(
        start: data["reviews"]["start"].to_i,
        end: data["reviews"]["end"].to_i,
        total: data["reviews"]["total"].to_i,
        books: books
      )
    end
	
	#Create a new book shelf - NOTE: requires OAuth
	#
	def create_shelf(shelf_name, exclusive_flag = "false", sortable_flag = "false", featured => "false")
		options = {"user_shelf[name]" => shelf_name, "user_shelf[exclusive_flag]" => exclusive_flag, "user_shelf[sortable_flag]" => sortable_flag, "user_shelf[featured]" => featured}
		data = oauth_request("/user_shelves.xml", options, "post")
	end
	
	#Edit and existing book shelf - NOTE: requires OAuth
	#
	def edit_shelf(shelf_id, shelf_name, exclusive_flag = "false", sortable_flag = "false", featured => "false")
		options = {"user_shelf[name]" => shelf_name, "user_shelf[exclusive_flag]" => exclusive_flag, "user_shelf[sortable_flag]" => sortable_flag, "user_shelf[featured]" => featured}
		data = oauth_request("/user_shelves/#{shelf_id}.xml", options, "put")
	end
	
	
	#Add a book to a shelf - Note: this is an OAuth Only request
	#
	def add_to_shelf(shelf, book_id)
		options = {"book_id" => book_id, "shelf" => shelf}
		data = oauth_request("/shelf/add_to_shelf.xml", options, method = "post")	
		return data
	end
	
	#Remove a book from a shelf - Note: this is an OAuth Only request
	#
	def remove_from_shelf(shelf, book_id)
		options = {"book_id" => book_id, "shelf" => shelf, "a" => "remove"}
		data = oauth_request("/shelf/add_to_shelf.xml", options, method = "post")	
		return data
	end
	
	#Add books to many shelves - Note: this is an OAuth Only request
	#
	def add_books_to_many_shelves(book_ids, shelf_names)
		#book_ids: comma-separated list of book ids
		#shelf_names: comma-separated list of shelf names
		options = {"bookids" => book_ids, "shelves" => shelf_names}
		data = oauth_request("/shelf/add_books_to_shelves.xml", options, method = "post")	
		return data
	end
	
  end
end
