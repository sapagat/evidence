require_relative '../spec_helper'
require_relative 'helpers/feature_helpers'
require_relative '../../infrastructure/s3'
require 'uri'

describe 'Instructions' do
  include FeatureHelpers

  let(:region) { 'test-region' }
  let(:bucket) { 'a-bucket' }
  let(:access_key_id) { 'an-access-key-id' }
  let(:secret_access_key) { 'a-secret-access-key' }

  before do
    remember_config
    Infrastructure::S3.configure do |config|
      config.region = region
      config.bucket = bucket
      config.access_key_id = access_key_id
      config.secret_access_key = secret_access_key
    end
  end

  after do
    restore_config
  end

  it 'provides an s3 http descriptor for uploading an evidence' do
    get('/instructions')

    expect(last_response.status).to eq(status_ok)
    instructions = last_parsed_response['instructions']
    expect_to_be_an_s3_presigned_url(instructions['url'])
    expect(instructions['method']).to eq('PUT')
  end

  it 'identifies the upload attempt' do
    get('/instructions')

    expect(last_parsed_response['attempt_id']).to be_a_uuid
  end

  def expect_to_be_an_s3_presigned_url(url)
    uri = URI.parse(url)
    expect(url).to include('s3')
    expect(url).to include(bucket)
    expect(url).to include(region)
    expect(uri.request_uri).to include(
      'X-Amz-Algorithm',
      'X-Amz-Credential',
      'X-Amz-Date',
      'X-Amz-Expires',
      'X-Amz-SignedHeaders',
      'X-Amz-Signature'
    )
  end

  def remember_config
    @s3_config = Infrastructure::S3.configuration.dup
  end

  def restore_config
    Infrastructure::S3.configure do |config|
      config.region = @s3_config.region
      config.bucket = @s3_config.bucket
      config.access_key_id = @s3_config.access_key_id
      config.secret_access_key = @s3_config.secret_access_key
    end
  end
end