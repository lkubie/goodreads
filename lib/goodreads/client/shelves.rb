module Goodreads
  module Shelves
    # Get books from a user's shelf
    def shelf(user_id, shelf_name, options = {})
	  if shelf_name == ""
		  options = options.merge(v: 2)
	  else
		  options = options.merge(shelf: shelf_name, v: 2, key: api_key)
	  end
	  #puts "Options:"
	  #puts options
	  puts "USER ID IN REQUEST: " + user_id
      data = oauth_request("/review/list/#{user_id}", options)
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
	def add_to_shelf(shelf, book_id)
		options = {}
		puts "made it to GR"
		options = options.merge(book_id: book_id, name: shelf)
		data = oauth_request("/shelf/add_to_shelf.xml", options, method = "post")
		puts data
		return data
	end
	
  end
end
