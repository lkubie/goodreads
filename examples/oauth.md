# Authorizing Goodreads via OAuth

For services requiring permission, such as write operations or browsing friends, the client must be authorized through OAuth.

## Request Tokens vs. Access Tokens

First, get an OAuth *request* token:

```ruby
request_token = OAuth::Consumer.new(
  Goodreads.configuration[:api_key],
  Goodreads.configuration[:api_secret],
  site: "http://www.goodreads.com"
).get_request_token
```

Next, authorize by opening the authorization URL in a browser:

```ruby
request_token.authorize_url
```

Then request an OAuth *access* token:

```ruby
access_token = request_token.get_access_token
```

Finally, initialize a Goodreads client with it:

```ruby
goodreads_client = Goodreads.new(oauth_token: access_token)
```

For more info, see the [Goodreads documentation](http://www.goodreads.com/api/oauth_example).

## Storing Token and Token Secret

Store the OAuth token and secret in your database to reuse later.
```ruby
@oauth_token_string = access_token.params[:oauth_token]
```
```ruby
@oauth_secret_string = access_token.params[:oauth_token_secret]		
```
Then store these to your User model (in this example we will store them as User.access_token and User.secret)


## Rebuiding an OAuth user

Using the token and secret stored for that use in your database, you can rebuild an authorized user.
Assuming your current_user is the logged in user.

```ruby
@consumer = OAuth::Consumer.new(
  Goodreads.configuration[:api_key],
  Goodreads.configuration[:api_secret],
  site: "http://www.goodreads.com"
)
user_oauth_token = current_user.access_token
user_oauth_token_secret = current_user.secret
access_token = OAuth::AccessToken.new(@consumer, user_oauth_token, user_oauth_token_secret) 

goodreads_client = Goodreads.new(oauth_token: access_token)
```




## User ID

Get the ID of the user who authorized via OAuth:

```ruby
goodreads_client.user_id
```

## Friends

Get the friend details for a user:

```ruby
friends_hash = goodreads_client.friends [user_id]
```

Get a list of their names:

```ruby
friends_hash.user.map{ |u| u.name }
```
