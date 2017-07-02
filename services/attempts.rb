require 'securerandom'
require_relative 'attempts/repository'

module Attempts
  class Service
    class << self
      def create
        id = generate_id
        attempt = { 'id' => id }
        Repository::store(attempt)
        attempt
      end

      private

      def generate_id
        SecureRandom.uuid
      end
    end
  end
end