require_relative 'spec_helper'
require_relative 'helpers/http_helpers'
require_relative 'helpers/warehouse_helpers'
require 'json'

describe 'Evidence' do
  include HttpHelpers
  after do
    flush_bucket
  end

  it 'completing an upload cycle' do
    ask_for_instructions

    upload_an_evidence

    resolve_upload

    expect_last_response_to_be_ok
  end

  def ask_for_instructions
    get '/instructions'
    expect_last_response_to_be_ok

    @attempt_id = last_parsed_response['attempt_id']
    @instructions = last_parsed_response['instructions']
  end

  def resolve_upload
    post '/resolve', { 'attempt_id' => @attempt_id }

    expect_last_response_to_be_ok
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
    expect_last_response_to_be_ok
  end

  def flush_bucket
    Warehouse::S3TestClient.flush_bucket
  end
end
