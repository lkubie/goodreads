module Goodreads
  module Books
    # Search for books
    #
    # query   - Text to match against book title, author, and ISBN fields.
    # options - Optional search parameters
    #
    # options[:page] - Which page to returns (default: 1)
    # options[:field] - Search field. One of: title, author, or genre (default is all)
    #
    def search_books(query, params = {}, oauth = true)
      params[:q] = query.to_s.strip
	  if oauth
		  data = oauth_request("/search/index", params)
	  else
		  data = request("/search/index", params)
	  end
      
      Hashie::Mash.new(data["search"])
    end

    # Get book details by Goodreads book ID
    #
    def book(id, oauth = true)
		if oauth
			data = oauth_request("/book/show", id: id)
		else
			data = request("/book/show", id: id)
		end
		
		Hashie::Mash.new(data["book"])
    end

    # Get book details by book ISBN
    #
    def book_by_isbn(isbn, oauth = true)
		if oauth
			data = oauth_request("/book/isbn", isbn: isbn)
		else
			data = request("/book/isbn", isbn: isbn)
		end
		Hashie::Mash.new(data["book"])
    end

    # Get book details by book title
    #
    def book_by_title(title, oauth = true)
		if oauth
			data = oauth_request("/book/title", title: title)
		else
			data = request("/book/title", title: title)
		end
		
		Hashie::Mash.new(data["book"])
    end
	def get_work_id(book_id_list, oauth = true)
		if oauth
			data = oauth_request("/book/id_to_work_id", id: book_id_list)
		else
			data = request("/book/id_to_work_id", id: book_id_list)
		end
		
		Hashie::Mash.new(data)
	end
  end
end
