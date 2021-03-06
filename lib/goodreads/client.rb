require "goodreads/client"
require "goodreads/client/books"
require "goodreads/client/reviews"
require "goodreads/client/authors"
require "goodreads/client/users"
require "goodreads/client/shelves"
require "goodreads/client/authorized"
require "goodreads/client/groups"
require "goodreads/client/friends"
require "goodreads/client/comments"
require "goodreads/client/events"
require "goodreads/client/listopia"
require "goodreads/client/owned_books"
require "goodreads/client/quotes"
require "goodreads/client/resources"
require "goodreads/client/read_statuses"
require "goodreads/client/recommendations"
require "goodreads/client/series"
require "goodreads/client/topics"
require "goodreads/client/statuses"

module Goodreads
  class Client
    include Goodreads::Request
    include Goodreads::Books
    include Goodreads::Reviews
    include Goodreads::Authors
    include Goodreads::Users
    include Goodreads::Shelves
    include Goodreads::Authorized
    include Goodreads::Groups
    include Goodreads::Friends
	include Goodreads::Comments
	include Goodreads::Events
	include Goodreads::Listopia
	include Goodreads::OwnedBooks
	include Goodreads::Quotes
	include Goodreads::Resources
	include Goodreads::ReadStatuses
	include Goodreads::Recommendations
	include Goodreads::Series
	include Goodreads::Topics
	include Goodreads::Statuses

    attr_reader :api_key, :api_secret, :oauth_token

    # Initialize a Goodreads::Client instance
    #
    # options[:api_key]     - Account API key
    # options[:api_secret]  - Account API secret
    # options[:oauth_token] - OAuth access token (optional, required for some calls)
    #
    def initialize(options = {})
      fail(ArgumentError, "Options hash required.") unless options.is_a?(Hash)

      @api_key    = options[:api_key] || Goodreads.configuration[:api_key]
      @api_secret = options[:api_secret] || Goodreads.configuration[:api_secret]
      #is this oauth_token actually a HASH?! Yes.
	  @oauth_token = options[:oauth_token]
	 
    end
  end
end
