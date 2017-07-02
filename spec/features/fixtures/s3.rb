module Fixtures
  class S3
    class << self
      def bucket
        'a-bucket'
      end

      def region
        'test-region'
      end

      def access_key_id
        'test-access-key-id'
      end

      def secret_access_key
        'test-secret-access-key'
      end
    end
  end
end