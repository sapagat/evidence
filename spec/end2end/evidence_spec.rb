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
  end

  def ask_for_instructions
    post '/provide_instructions', auth_message('key' => evidence_key)
    expect_last_response_to_be_ok
    expect(last_status).to eq('ok')

    @ticket = last_data['ticket']
    @instructions = last_data['instructions']
  end

  def resolve_upload
    post '/resolve_attempt', auth_message('ticket' => @ticket)

    expect_last_response_to_be_ok
    expect(last_status).to eq('ok')
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

  def evidence_key
    'reports.pdf'
  end

  def flush_bucket
    Warehouse::S3TestClient.flush_bucket
  end
end
