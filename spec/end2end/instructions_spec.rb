require_relative './spec_helper'
require_relative 'helpers/matchers'
require_relative 'helpers/http_helpers'

describe 'Instructions' do
  include HttpHelpers

  it 'provides an s3 http descriptor for uploading an evidence' do
    get('/instructions')

    expect(last_response.code).to eq('200')
    instructions = last_parsed_response['instructions']
    expect(instructions['url']).to be_an_s3_presigned_url
    expect(instructions['method']).to eq('PUT')
  end
end