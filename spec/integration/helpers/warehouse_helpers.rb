require_relative '../../../config/initializers/s3'
require_relative '../../../src/service/warehouse'

module Warehouse
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
end