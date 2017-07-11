require_relative 'spec_helper'
require_relative 'helpers/attempts_helpers'
require_relative '../../src/service/warehouse'

RSpec.describe 'Instructions' do
  it 'provides an s3 http descriptor for uploading an evidence' do
    key = a_key
    post('/provide_instructions', message({ 'key' => key}))

    expect(last_response.status).to eq(status_ok)
    expect(last_parsed_response['key']).to eq(key)
    instructions = last_parsed_response['instructions']
    expect_to_be_upload_instructions(instructions)
  end

  it 'identifies the upload attempt' do
    key = a_key

    post('/provide_instructions', message({ 'key' => key }))

    expect(last_parsed_response['attempt_id']).to be_a_uuid
  end

  context 'when the key is not specified' do
    it 'responds with an error status' do
      post('/provide_instructions', message({}))

      expect(last_response.status).to eq(error_status)
    end
  end

  def a_key
    '/some/file.txt'
  end

  def expect_to_be_upload_instructions(instructions)
    fixture = Stubs::S3Client::INSTRUCTIONS
    expect(instructions['url']).to eq(fixture['url'])
    expect(instructions['method']).to eq(fixture['method'])
  end
end
