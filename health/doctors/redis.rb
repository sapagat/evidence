require_relative '../../infrastructure/redis'

module Doctors
  class Redis
    class << self
      def check
        check_service_is_reachable!

        { 'status' => 'ok' }
      rescue StandardError
        { 'status' => 'error' }
      end

      private

      def check_service_is_reachable!
        redis_client.ping
      end

      def redis_client
        Infrastructure::Redis.build_client
      end
    end
  end
end