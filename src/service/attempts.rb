require_relative '../../config/configurable'
require_relative '../domain/attempt'
require_relative '../../infrastructure/redis'
require 'redis'
require 'json'

module Attempts
  class Repository
    include Configurable

    configure_with :client

    class << self
      def register(payload)
        attempt = Attempt.for(payload)

        client.store(attempt.ticket, payload)

        attempt
      end

      def exchange(ticket)
        return NullAttempt.new unless client.exists?(ticket)

        payload = client.find(ticket)
        client.destroy(ticket)
        Attempt.new(ticket, payload)
      end

      private

      def client
        configuration.client
      end
    end
  end

  class RedisClient
    class << self
      def store(key, payload)
        redis_client.hset(key, key, JSON.dump(payload))
      end

      def destroy(key)
        redis_client.del(key)
      end

      def find(key)
        payload_json = redis_client.hget(key, key)
        return unless payload_json

        JSON.parse(payload_json)
      end

      def exists?(key)
        stored = find(key)
        !stored.nil?
      end

      private

      def redis_client
        Infrastructure::Redis.client
      end
    end
  end
end
