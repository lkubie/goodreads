module Goodreads
	module Authors
		# Get author details
		#
		def author(id, oauth = true)
			options = {"id"=> id}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/author/show", options)
			else
				data = request("/author/show", options)
			end
			Hashie::Mash.new(data)
		end
	
	
		#Get a list of an Authors Books by their ID
		#
		def author_books(id, page = 1, oauth = true)
			options = {"id"=> id, "page" => page}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/author/list", options)
			else
				data = request("/author/list", options)
			end
			Hashie::Mash.new(data["author"])
		end
	
		#follow an author - Note: this is OAuth ONLY
		#
		def follow_author(id)
			options = {"id"=> id}
			data = oauth_request("/author_followings", options, "post")
		end
	
		#unfollow an author- Note: I'm not sure how to get a following_id currently...
		# - Note: this is OAuth ONLY
		def unfollow_author(following_id)
			options = {}
			oauth_request("/author_followings/#{following_id}", options, "delete")
		end
	
		#Get author following info.  Note: I'm not sure how to get a following_id currently...
		#Note: this is OAuth ONLY
		def author_following_info(following_id)
			options = {}
			data = oauth_request("/author_followings/#{following_id}", options, "get")
			Hashie::Mash.new(data)
		end
	
		# Search for an author by name
		#
		def author_by_name(name, params = {}, oauth = true)
			options = {}
			name_encoded = URI.encode(name)
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/api/author_url/#{name_encoded}", options)
			else
				data = request("/api/author_url/#{name_encoded}", options)
			end     
			Hashie::Mash.new(data["author"])
		end
	end
end