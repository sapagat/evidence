require_relative '../../../src/service/attempts'

module Attempts
  class TestRepository < Repository
    class << self
      def flush
        client.flush
      end

      def store(attempt)
        client.store(attempt['ticket'], attempt)
      end

      def exists?(key)
        client.exists?(key)
      end

      private

      def client
        MemoryClient
      end
    end
  end

  class MemoryClient
    @@attempts = {}

    def self.store(key, value)
      @@attempts[key] = value
    end

    def self.destroy(key)
      @@attempts.delete(key)
    end

    def self.find(key)
      @@attempts[key]
    end

    def self.exists?(key)
      !@@attempts[key].nil?
    end

    def self.flush
      @@attempts = {}
    end
  end
end