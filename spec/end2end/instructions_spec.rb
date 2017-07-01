require_relative './spec_helper'
require_relative 'helpers/http_helpers'
require 'uri'

describe 'Instructions' do
  include HttpHelpers

  it 'provides an s3 http descriptor for uploading an evidence' do
    get('/instructions')

    expect(last_response.code).to eq('200')
    instructions = last_parsed_response['instructions']
    expect_to_be_an_s3_presigned_url(instructions['url'])
    expect(instructions['method']).to eq('PUT')
  end

  def expect_to_be_an_s3_presigned_url(url)
    uri = URI.parse(url)
    expect(url).to include('s3')
    expect(url).to include('a-bucket')
    expect(uri.request_uri).to include(
      'X-Amz-Algorithm',
      'X-Amz-Credential',
      'X-Amz-Date',
      'X-Amz-Expires',
      'X-Amz-SignedHeaders',
      'X-Amz-Signature'
    )
  end
end