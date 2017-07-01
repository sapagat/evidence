require 'aws-sdk-resources'

module Infrastructure
  class S3
    class << self
      def resource
        Aws::S3::Resource.new(client: client)
      end

      def client
        Aws::S3::Client.new({
          region: ENV['S3_REGION'],
          access_key_id: ENV['S3_ACCESS_KEY_ID'],
          secret_access_key: ENV['S3_SECRET_ACCESS_KEY']
        })
      end

      def bucket
        ENV['S3_BUCKET']
      end
    end
  end
end