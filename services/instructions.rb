require 'aws-sdk-resources'
require 'uri'

module Instructions
  class Service
    class << self
      def retrieve
        url = generate_url
        {
          'url' => url,
          'method' => 'PUT'
        }
      end

      private

      def generate_url
        bucket = 'a_bucket'
        filename = 'test.txt'
        object = s3_resource.bucket(bucket).object(filename)
        url = URI.parse(object.presigned_url(:put))
        url
      end

      def s3_resource
        Aws::S3::Resource.new(client: s3_client)
      end

      def s3_client
        Aws::S3::Client.new({
          region: 'a_region',
          access_key_id: 'an_access_key_id',
          secret_access_key: 'a_secret_access_key'
        })
      end
    end
  end
end