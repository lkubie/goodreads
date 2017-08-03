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

    # Search for an author by name
    #
    def author_by_name(name, params = {})
      params[:id] = name
      name_encoded = URI.encode(name)
      data = request("/api/author_url/#{name_encoded}", params)
      Hashie::Mash.new(data["author"])
    end
  end
end
