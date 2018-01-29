require 'net/http'
require 'uri'
require 'json'

# define access parameters
endpoint = "<endpoint>"
access_token = "<access_token>"

# define request parameters
submission_id = "2017"

# send request
uri = URI.parse("https://" + endpoint + "/api/v4/submissions/" + submission_id + "?access_token=" + access_token)
http = Net::HTTP.new(uri.host, uri.port)

begin
    response = http.request(Net::HTTP::Get.new(uri.request_uri))

    # process response
    case response
        when Net::HTTPSuccess
            puts JSON.parse(response.body)
        when Net::HTTPUnauthorized
            puts "Invalid access token"
        when Net::HTTPForbidden
            puts "Access denied"
        when Net::HTTPNotFound
            puts "Submission not found"
    end
rescue => e
    puts "Connection error"
end