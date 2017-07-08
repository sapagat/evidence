require_relative 'spec_helper'
require_relative '../../services/warehouse'
require_relative '../../config/initializers/s3'

RSpec.describe 'Warehouse' do
  describe 'instructions_for' do
    it 'provides pre-signed request instructions' do
      instructions = Warehouse.instructions_for(filename)

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
        filename
      )
    end
  end

  describe 'exists?' do
    after do
      flush_bucket
    end

    it 'knows when a file is stored' do
      S3TestClient.store(filename, 'Any content')

      expect(Warehouse.exists?(filename)).to eq(true)
    end

    it 'knows when a file is not stored' do
      expect(Warehouse.exists?(filename)).to eq(false)
    end

    def flush_bucket
      S3TestClient.flush_bucket
    end
  end

  def filename
    'a_filename.txt'
  end
end

require_relative '../../config/initializers/s3'
require_relative '../../services/s3_client'
class S3TestClient < S3Client
  class << self
    def store(key, content)
      resource.bucket(bucket).object(key).put(body: content)
    end

    def flush_bucket
      resource.bucket(bucket).objects.each do |object|
        object.delete
      end
    end
  end
end