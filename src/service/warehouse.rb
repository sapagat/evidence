require_relative '../../infrastructure/s3'
require_relative '../../config/configurable'
require 'uri'

module Warehouse
  class Gateway
    include Configurable

    configure_with :client

    class << self
      def instructions_for(key)
        client.build_instructions(key)
      end

      def exists?(key)
        client.exists?(key)
      end

      private

      def client
        configuration.client
      end
    end
  end

  class S3Client
    class << self
      def build_instructions(key)
        object = resource.bucket(bucket).object(key)
        url = object.presigned_url(:put)
        {
          'url' => url,
          'method' => 'PUT'
        }
      end

      def exists?(key)
         resource.bucket(bucket).object(key).exists?
      end

      def create_bucket
        resource.create_bucket(bucket: bucket)
      end

      private

      def resource
        Infrastructure::S3.resource
      end

      def bucket
        Infrastructure::S3.bucket
      end
    end
  end
end