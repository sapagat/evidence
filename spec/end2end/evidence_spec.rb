require_relative 'spec_helper'
require_relative 'helpers/http_helpers'
require 'json'

describe 'Evidence' do
  include HttpHelpers
  after do
    flush_bucket
  end

  it 'completing an upload cycle' do
    ask_for_instructions

    upload_an_evidence
    expect_last_response_to_be_ok

    resolve_upload

    expect_last_response_to_be_ok
  end

  def ask_for_instructions
    get '/instructions'
    @attempt_id = last_parsed_response['attempt_id']
    @instructions = last_parsed_response['instructions']
  end

  def resolve_upload
    post '/resolve', { 'attempt_id' => @attempt_id }
  end

  def expect_last_response_to_be_ok
    expect(last_response.code).to eq('200')
  end

  def upload_an_evidence
    url = @instructions['url']
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.request_uri, 'Content-Type' => '')
    request.body = 'Some random file content'

    @last_response = http.request(request)
  end

  def flush_bucket
    require_relative '../../services/warehouse'
    S3TestClient.flush_bucket
  end
end

require_relative '../../config/initializers/s3'
require_relative '../../services/s3_client'
class S3TestClient < S3Client
  class << self
    def flush_bucket
      resource.bucket(bucket).objects.each do |object|
        object.delete
      end
    end
  end
end