module Goodreads
	module Topics
	  
		#Create a new topic - NOTE: this is OAuth only
		#
		def new_topic(subject_type,subject_id, title, body, folder_id = nil, question_flag = 0, update_feed = 'off', digest = 'off')
			if subject_type == "Book" || subject_type == "Group"
				options = {"topic[subject_type]" => subject_type, "topic[subject_id]" => subject_id, "topic[title]" => title, "comment[body_usertext]" => body, "topic[question_flag]" => question_flag, "update_feed" => update_feed, "digest" => digest}
				if !folder_id.nil?
					options["topic[folder_id]"] = folder_id
				end
				data = oauth_request("/topic.xml", options, "post")
			else
				puts "unallowed subject_type entered. Allowed values are 'Book' and 'Group'. You entered: #{subject_type}"
			end
		end
	  
	  
		#Get list of topics in a group's folder
		#
		def list_topics(group_id, folder_id = 0, page = 1, sort = 'updated_at', order = 'a', oauth = true)
			if ['comments_count', 'title', 'updated_at', 'views'].include?(sort) && ['a', 'd'].include?(order)
				options = {"group_id" => group_id, "page" => page, "sort" => sort, "order" => order}
			else
				puts "NOTICE: invalid sorting parameters entered. reverting to defults."
				options = {"group_id" => group_id, "page" => page}
			end
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/topic/group_folder/#{folder_id}", options)
			else
				data = request("/topic/group_folder/#{folder_id}", options)
			end
			Hashie::Mash.new(data)
		end
		
		#Get info about a topic
		#
		def get_topic(topic_id, oauth = true)
			options = {"id" => topic_id}
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/topic/show.xml", options)
			else
				data = request("/topic/show.xml", options)
			end
			Hashie::Mash.new(data)
		end
	  
		#Get a list of topics from a specified group that have comments added since the last time the user viewed the topic
		#Note:OAuth Only
		def topics_unread_comments(group_id, viewed = 0, page = 1, sort = 'updated_at', order = 'a')
			if ['comments_count', 'title', 'updated_at', 'views'].include?(sort) && ['a', 'd'].include?(order)
				options = {"viewed" => viewed, "page" => page, "sort" => sort, "order" => order}
			else
				puts "NOTICE: invalid sorting parameters entered. reverting to defults."
				options = {"viewed" => viewed, "page" => page}
			end
			data = oauth_request("/topic/unread_group/#{group_id}", options)
			Hashie::Mash.new(data)
	  
	end
end