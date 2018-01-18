require 'net/http'
require 'uri'
require 'json'

# define access parameters
endpoint = "<endpoint>"
access_token = "<access_token>"

# define request parameters
submission_data = {
    "compilerId" => "11",
    "source" => '<source_code>'
};

# send request
uri = URI.parse("http://" + endpoint + "/api/v4/submissions?access_token=" + access_token)
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
        when Net::HTTPPaymentRequired
            puts "Unable to create submission"
        when Net::HTTPBadRequest
            body = JSON.parse(response.body)
            puts "Error code: " + body["error_code"].to_s + ", details available in the message: " + body["message"].to_s
    end
rescue => e
    puts "Connection error"
end