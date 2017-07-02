require_relative 'spec_helper'
require_relative 'helpers/attempts_helpers'
require 'uri'

RSpec.describe 'Evidence' do
  describe 'Instructions' do
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

    def bucket
      Fixtures::S3.bucket
    end

    def region
      Fixtures::S3.region
    end
  end

  describe 'Resolve' do
    it 'resolves when the attempt is valid' do
      store_attempt({'id' => '1234'})

      post '/resolve', message({ 'attempt_id' => '1234'})

      expect(last_response.status).to eq(status_ok)
    end

    context 'when the attempt has been consumed' do
      it 'responds with an error status' do
        store_attempt({'id' => '1234'})
        post '/resolve', message({ 'attempt_id' => '1234'})

        post '/resolve', message({ 'attempt_id' => '1234'})

        expect(last_response.status).to eq(error_status)
      end
    end

    context 'when the attempt is not valid' do
      it 'responds with an error status' do
        post '/resolve', message({ 'attempt_id' => invalid_attempt_id})

        expect(last_response.status).to eq(error_status)
      end

      def invalid_attempt_id
        'INVALID'
      end
    end

    def store_attempt(attempt)
      Attempts::TestRepository.store(attempt)
    end
  end
end
