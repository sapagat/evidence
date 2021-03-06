require_relative 'spec_helper'
require_relative '../../src/service/warehouse'
require_relative 'helpers/warehouse_helpers'

RSpec.describe 'Warehouse' do
  before do
    Warehouse::Gateway.configure do |config|
      config.client = Warehouse::S3Client
    end
  end

  describe 'instructions_for' do
    it 'provides pre-signed request instructions' do
      instructions = Warehouse::Gateway.instructions_for(key)

      expect_to_be_an_s3_presigned_url(instructions['url'])
    end

    def expect_to_be_an_s3_presigned_url(url)
      uri = URI.parse(url)
      expect(url).to include('s3')
      expect(url).to include(Fixtures::S3.bucket)
      expect(url).to include(Fixtures::S3.region)
      expect(uri.request_uri).to include(
        'X-Amz-Algorithm',
        'X-Amz-Credential',
        'X-Amz-Date',
        'X-Amz-Expires',
        'X-Amz-SignedHeaders',
        'X-Amz-Signature',
        key
      )
    end
  end

  describe 'exists?' do
    after do
      flush_bucket
    end

    it 'knows when a file is stored' do
      store_evidence(key, 'Any content')

      expect(Warehouse::Gateway.exists?(key)).to eq(true)
    end

    it 'knows when a file is not stored' do
      expect(Warehouse::Gateway.exists?(key)).to eq(false)
    end

    def store_evidence(key, content)
      Warehouse::S3TestClient.store(key, 'Any content')
    end

    def flush_bucket
      Warehouse::S3TestClient.flush_bucket
    end
  end

  def key
    'a_filename.txt'
  end
end