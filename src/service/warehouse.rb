require_relative '../../infrastructure/s3'
require 'uri'

module Warehouse
  class << self
    def instructions_for(filename)
      client.build_instructions(filename)
    end

    def exists?(filename)
      client.exists?(filename)
    end

    private

    def client
      return @client if @client

      build_client
    end

    def build_client
      @client = S3Client
    end
  end

  class S3Client
    class << self
      def build_instructions(filename)
        object = resource.bucket(bucket).object(filename)
        url = object.presigned_url(:put)
        {
          'url' => url,
          'method' => 'PUT'
        }
      end

      def exists?(filename)
         resource.bucket(bucket).object(filename).exists?
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