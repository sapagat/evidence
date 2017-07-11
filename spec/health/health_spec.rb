require 'net/http'
require 'uri'
require 'json'

RSpec.describe 'Evidence', :watchdog do
  it 'needs the service to be up' do
    get('/health')

    expect(last_response.code).to eq('200')
  end

  it 'needs s3 to be reachable' do
    get('/health')

    expect(dependencies['s3']).to eq({'status' => 'ok'})
  end

  def dependencies
    last_parsed_response['dependencies']
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

  def last_parsed_response
    JSON.parse(@last_response.body)
  end

  def base_url
    'http://localhost'
  end
end