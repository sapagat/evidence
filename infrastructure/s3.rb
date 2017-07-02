require 'aws-sdk-resources'
require_relative '../config/configurable'

module Infrastructure
  class S3
    include Configurable

    configure_with :region, :access_key_id, :secret_access_key, :bucket

    class << self
      def resource
        Aws::S3::Resource.new(client: client)
      end

      def client
        Aws::S3::Client.new({
          region: configuration.region,
          access_key_id: configuration.access_key_id,
          secret_access_key: configuration.secret_access_key
        })
      end

      def bucket
        configuration.bucket
      end
    end
  end
end