module Fixtures
  class S3
    class << self
      def bucket
        'a-bucket'
      end

      def region
        'us-east-1'
      end

      def access_key_id
        'an_access_key_id'
      end

      def secret_access_key
        'a_secret_access_key'
      end
    end
  end
end