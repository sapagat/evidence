require 'net/http'
require 'uri'
require 'json'

describe 'Evidence' do
  it 'needs the service to be up' do
    get('/health')

    expect(last_response.code).to eq('200')
  end

  def get(endpoint)
    uri = build_uri(endpoint)
    @last_response = Net::HTTP.get_response(uri)
  end

  def last_response
    @last_response
  end

  def build_uri(endpoint)
    URI.parse(base_url + endpoint)
  end

  def base_url
    'http://localhost'
  end
end