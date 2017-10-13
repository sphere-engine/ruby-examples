require 'net/http'
require 'uri'
require 'json'

# define access parameters
endpoint = "<endpoint>"
access_token = "<access_token>"

# define request parameters
submission_data = {
    "problemCode" => 'EXAMPLE',
    "compilerId" => "11",
    "source" => '<source_code>'
};

# send request
uri = URI.parse("http://" + endpoint + "/api/v3/submissions?access_token=" + access_token)
http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Post.new(uri.request_uri);
request.set_form_data(submission_data)

begin
    response = http.request(request)

    # process response
    case response
        when Net::HTTPCreated
            puts JSON.parse(response.body)
        when Net::HTTPUnauthorized
            puts "Invalid access token"
        when Net::HTTPBadRequest
            puts "Empty source code"
        when Net::HTTPForbidden
            puts "Compiler not available"
        when Net::HTTPNotFound
            puts "Problem, compiler or user not found"
    end
rescue => e
    puts "Connection error"
end