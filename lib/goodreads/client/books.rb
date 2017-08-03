module Goodreads
  module Books
    # Search for books - note: can't use OAuth for this method currently.
    #
    # query   - Text to match against book title, author, and ISBN fields.
    # options - Optional search parameters
    #
    # options[:page] - Which page to returns (default: 1)
    # options[:field] - Search field. One of: title, author, or genre (default is all)
    #
    def search_books(query, params = {})
      params[:q] = query.to_s.strip
	  data = request("/search/index", params)
      Hashie::Mash.new(data["search"])
    end

    # Get book details by Goodreads book ID - note: can't use OAuth for this method currently.
    #
    def book(id)
		data = request("/book/show", id: id)
		Hashie::Mash.new(data["book"])
    end

    # Get book details by book ISBN - note: can't use OAuth for this method currently.
    #
    def book_by_isbn(isbn)
		data = request("/book/isbn", isbn: isbn)
		Hashie::Mash.new(data["book"])
    end

    # Get book details by book title - note: can't use OAuth for this method currently.
    #
    def book_by_title(title)
		data = request("/book/title", title: title)
		Hashie::Mash.new(data["book"])
    end
	
	#Get Goodreads work id for a given book ID - note: can't use OAuth for this method currently.
	#
	def get_work_id(book_id_list)
		data = request("/book/id_to_work_id", id: book_id_list)
		Hashie::Mash.new(data)
	end
	
	#Get Review Statistics given a list of ISBNs
	#
	def get_review_statistics_from_isbn(isbns)
		#note, isbns can be a single isbn or a string of isbns seperated by commans ex: "111111111,2222222222,3333333333"
		data = request("/review_counts.json", isbns: isbns)
		Hashie::Mash.new(data)
	end
  end
end
