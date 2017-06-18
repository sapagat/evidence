require 'net/http'
require 'uri'
require 'json'

module HttpHelpers
  BASE_URL = 'http://localhost'

  def get(endpoint)
    uri = build_uri(endpoint)
    @last_response = Net::HTTP.get_response(uri)
  end

  def build_uri(endpoint)
    URI.parse(BASE_URL + endpoint)
  end

  def last_response
    @last_response
  end

  def last_parsed_response
    JSON.parse(@last_response.body)
  end
end