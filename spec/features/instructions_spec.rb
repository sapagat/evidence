require_relative 'spec_helper'
require_relative 'helpers/attempts_helpers'
require_relative '../../services/warehouse'
require_relative '../../services/s3_client'

RSpec.describe 'Instructions' do
  it 'provides an s3 http descriptor for uploading an evidence' do
    allow(S3Client).to receive(:build_instructions).and_return({
      'url' => 'an_url',
      'method' => 'PUT'
    })

    get('/instructions')

    expect(last_response.status).to eq(status_ok)
    instructions = last_parsed_response['instructions']
    expect(instructions['url']).to eq('an_url')
    expect(instructions['method']).to eq('PUT')
  end

  it 'identifies the upload attempt' do
    get('/instructions')

    expect(last_parsed_response['attempt_id']).to be_a_uuid
  end
end
