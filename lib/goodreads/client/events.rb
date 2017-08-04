module Goodreads
	module Events
	  
		#List events in an area
		#
		def list_events(lat = "", lng = "", country_code = "", postal_code = "", oauth = true)
			#lat: Latitude (optional)
			#lng: Longitude (optional)
			#country_code: 2 characters country code (optional)
			#postal_code: ZIP code (optional)
			options = {}
			if lat != ""
				options["lat"] = lat
			end
			if lng != ""
				options["lng"] = lng
			end
			if country_code != ""
				options["search[country_code]"] = country_code
			end
			if postal_code != ""
				options["search[postal_code]"] = postal_code
			end
			if oauth
				options.merge!(key: Goodreads.configuration[:api_key])
				data = oauth_request("/event/index.xml", options)
			else
				data = request("/event/index.xml", options)
			end	
			Hashie::Mash.new(data)
		end
	end
end