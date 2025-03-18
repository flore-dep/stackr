# github_invite = Faraday.new(url: 'https://api.github.com/orgs/ORG/invitations') do |builder|
#   # Calls MyAuthStorage.get_auth_token on each request to get the auth token
#   # and sets it in the Authorization header with Bearer scheme.
#   builder.request :authorization, 'Bearer', -> {ENV.fetch("GITHUB_ACCESS_TOKEN")}

#   # Sets the Content-Type header to application/json on each request.
#   # Also, if the request body is a Hash, it will automatically be encoded as JSON.
#   builder.request :json

#   # Parses JSON response bodies.
#   # If the response body is not valid JSON, it will raise a Faraday::ParsingError.
#   builder.response :json

#   # Raises an error on 4xx and 5xx responses.
#   builder.response :raise_error

#   # Logs requests and responses.
#   # By default, it only logs the request method and URL, and the request/response headers.
#   builder.response :logger
# end
