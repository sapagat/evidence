require 'net/http'
require 'uri'
require 'json'

module HttpHelpers
  BASE_URL = 'http://localhost'

  def get(endpoint)
    uri = build_uri(endpoint)
    @last_response = Net::HTTP.get_response(uri)
  end

  def post(endpoint, message)
    uri = build_uri(endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
    request.body = JSON.dump(message)

    @last_response = http.request(request)
  end

  def auth_message(message)
    message['auth_token'] = ENV['AUTH_TOKEN']
    message
  end

  def build_uri(endpoint)
    URI.parse(BASE_URL + endpoint)
  end

  def last_status
    last_parsed_response['status']
  end

  def last_data
    last_parsed_response['data']
  end

  def last_response
    @last_response
  end

  def last_parsed_response
    JSON.parse(@last_response.body)
  end
end