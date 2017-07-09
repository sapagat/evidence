require_relative 'spec_helper'
require_relative 'helpers/attempts_helpers'
require_relative '../../src/service/warehouse'

RSpec.describe 'Instructions' do
  it 'provides an s3 http descriptor for uploading an evidence' do
    get('/instructions')

    expect(last_response.status).to eq(status_ok)
    instructions = last_parsed_response['instructions']
    expect_to_be_upload_instructions(instructions)
  end

  it 'identifies the upload attempt' do
    get('/instructions')

    expect(last_parsed_response['attempt_id']).to be_a_uuid
  end

  def expect_to_be_upload_instructions(instructions)
    fixture = Stubs::S3Client::INSTRUCTIONS
    expect(instructions['url']).to eq(fixture['url'])
    expect(instructions['method']).to eq(fixture['method'])
  end
end
