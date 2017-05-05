module Goodreads
  module Authorized
    def user_id
      oauth_request("/api/auth_user")["user"]["id"]
    end
    def user_all
      oauth_request("/api/auth_user")["user"]
    end
  end
end
