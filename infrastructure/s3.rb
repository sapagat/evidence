require 'aws-sdk-resources'
require_relative '../config/configurable'

module Infrastructure
  class S3
    include Configurable

    configure_with :region, :access_key_id, :secret_access_key, :bucket, :endpoint

    class << self
      def resource
        Aws::S3::Resource.new(client: client)
      end

      def client
        Aws::S3::Client.new(config)
      end

      def bucket
        configuration.bucket
      end

      private

      def config
        settings = {
          region: configuration.region,
          access_key_id: configuration.access_key_id,
          secret_access_key: configuration.secret_access_key,
        }
        if configuration.endpoint
          settings[:endpoint] = configuration.endpoint
          settings[:force_path_style] = true
        end

        settings
      end
    end
  end
end