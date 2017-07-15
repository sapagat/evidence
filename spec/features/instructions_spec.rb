require_relative 'spec_helper'
require_relative 'helpers/attempts_helpers'
require_relative '../../src/service/warehouse'

RSpec.describe 'Instructions' do
  it 'provides an s3 http descriptor for uploading an evidence' do
    key = a_key
    post('/provide_instructions', auth_message({ 'key' => key}))

    expect(last_status).to eq('ok')
    expect(last_data['key']).to eq(key)
    instructions = last_data['instructions']
    expect_to_be_upload_instructions(instructions)
  end

  it 'identifies the upload attempt' do
    key = a_key

    post('/provide_instructions', auth_message({ 'key' => key }))

    expect(last_data['attempt_id']).to be_a_uuid
  end

  context 'when the key is not specified' do
    it 'responds with an error status' do
      post('/provide_instructions', auth_message({}))

      expect(last_status).to eq('error')
      expect(last_error).to eq('invalid_key')
    end
  end

  context 'when not authorized' do
    it 'responds with an unauthorized error' do
      post('/provide_instructions', message({'key' => 'any_key'}))

      expect(last_status).to eq('error')
      expect(last_error).to eq('unauthorized')
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
