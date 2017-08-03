module Goodreads
  module Authors
    # Get author details
    #
    def author(id, params = {}, oauth = true)
		params[:id] = id
		if oauth
			data = oauth_request("/author/show", params)
		else
			data = request("/author/show", params)
		end
		Hashie::Mash.new(data["author"])
    end
	
	
	#Get a list of an Authors Books by their ID
	#
    def author_books(id, params = {}, oauth = true)
		params[:id] = id
		if oauth
			data = oauth_request("/author/list", params)
		else
			data = request("/author/list", params)
		end
		Hashie::Mash.new(data["author"])
    end
	
	#follow an author
	#
	def follow_author(id)
		#Note: this is OAuth ONLY
		options = {"id"=> id, "format"=> "xml"}
		data = oauth_request("/author_followings", options, "post")
		
	end
    # Search for an author by name
    #
    def author_by_name(name, params = {}, oauth = true)
      params[:id] = name
      name_encoded = URI.encode(name)
	  if oauth
		  data = oauth_request("/api/author_url/#{name_encoded}", params)
	  else
		  data = request("/api/author_url/#{name_encoded}", params)
	  end
      
      Hashie::Mash.new(data["author"])
    end
  end
end

#Book.setClient(User.find(1)).author(18541)