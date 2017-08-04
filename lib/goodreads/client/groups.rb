module Goodreads
	module Groups
		# Get group details
		#
		def group(group_id, oauth = true)
			options = {"id" => group_id}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/group/show", options)
			else
				data = request("/group/show", options)
			end
			Hashie::Mash.new(data["group"])
		end

	
		#Join a group- Note: this requires OAuth
		#
		def join_group(id)
			#id: ID of the group to join
			options = {"id" => id}
			data = oauth_request("/group/join", options, "post")
		end
		
		# Returns xml list of groups the user specified by id belongs to 
		#
		def list_users_group(user_id, sort = "title", oauth = true)
			if sort != "my_activity" && sort != "members" && sort != "last_activity" && sort != "title"
				puts "NOTICE: unallowed sort parameter used. Reverting to 'title' default"
				sort = "title"
			end
			options = {"sort" => sort}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/group/list/#{user_id}.xml", options)
			else
				data = oauth_request("/group/list/#{user_id}.xml", options)
			end
			Hashie::Mash.new(data)
		end
	
		def group_members(group_id, sort, name = "", page = 1, oauth = true)
			#name : List of names to search for, separating each name with a space character. Optional, will find all members by default
			if sort != "last_online" && sort != "num_comments" && sort != "date_joined" && sort != "num_books" && sort != "first_name"
				puts "NOTICE: Invalid sort parameter. Reverting to 'first_name' default."
				sort = "first_name"
			end
			if name = ""
				options = {"sort" => sort, "page" => page}
			else
				name_encoded = URI.encode(name)
				options = {"sort" => sort, "q" => name, "page" => page}
			end
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/group/members/#{group_id}.xml", options)
			else
				data = request("/group/members/#{group_id}.xml", options)
			end
			Hashie::Mash.new(data)
		end
	
		#Find a group by name or description
		#
		def find_group(query_string, page = 1, oauth = true)
			options = {"q" => query_string, "page" => page}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/group/search.xml", options)
			else
				data = request("/group/search.xml", options)
			end
			Hashie::Mash.new(data)
		end
	
	end
end
