require_relative '../../infrastructure/s3'

module Doctors
  class S3
    class << self
      def check
        check_service_is_reachable!

        { 'status' => 'ok'}
      rescue StandardError
        { 'status' => 'error'}
      end

      private

      def check_service_is_reachable!
        client.head_bucket({ bucket: bucket })
      end

      def bucket
        Infrastructure::S3.bucket
      end

      def client
        Infrastructure::S3.client
      end
    end
  end
end