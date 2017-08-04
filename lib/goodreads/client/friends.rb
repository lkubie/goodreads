module Goodreads
  module Friends
    # Get the specified user's friends
    #
    # user_id - integer or string
    #
    def friends(user_id)
      data = oauth_request("/friend/user/#{user_id}")
      Hashie::Mash.new(data["friends"])
    end
	
	
	# Confirm or Reject a Friend Recomendation - Note: requires OAuth
	#
	def respond_friend_recommendation(recommendation_id, response)
		#response must be either "Y" or "N"
		options = {"id" => recommendation_id, "response" => response}
		case response
		when "Y","N"
			data = oauth_request("/friend/confirm_recommendation.xml", options, "post")
		else
			puts "responce must be either Y or N, you entered: " + response
		end
	end
	
	# Confirm or Reject a Friend Request - Note: requires OAuth
	#
	def respond_friend_request(friend_request_id, response)
		#response must be either "Y" or "N"
		options = {"id" => friend_request_id, "response" => response}
		case response
		when "Y","N"
			data = oauth_request("/friend/confirm_request.xml", options, "post")
		else
			puts "responce must be either Y or N, you entered: " + response
		end
	end
	
	# Lists Friend Requests - Note: requires OAuth
	#
	def friend_requests(page = 1)
		options = {"page" => page}
		data = oauth_request("/friend/requests.xml", options)
		Hashie::Mash.new(data)
	end
	
	
	# Lists Friend Reccomendations - Note: requires OAuth
	#
	def friend_recommendations(page = 1)
		options = {"page" => page}
		data = oauth_request("/friend/recommendations.xml", options)
		Hashie::Mash.new(data)
	end
	
  end
end
