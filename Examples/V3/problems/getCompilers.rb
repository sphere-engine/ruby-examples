require 'net/http'
require 'uri'
require 'json'

# define access parameters
endpoint = "<endpoint>"
access_token = "<access_token>"

# send request
uri = URI.parse("https://" + endpoint + "/api/v3/compilers?access_token=" + access_token)
http = Net::HTTP.new(uri.host, uri.port)

begin
    response = http.request(Net::HTTP::Get.new(uri.request_uri))

    # process response
    case response
        when Net::HTTPSuccess
            puts JSON.parse(response.body)
        when Net::HTTPUnauthorized
            puts "Invalid access token"
    end
rescue => e
    puts "Connection error"
end