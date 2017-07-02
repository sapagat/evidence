require 'securerandom'

module Attempts
  class Service
    class << self
      def create
        id = generate_id
        { 'id' => id }
      end

      private

      def generate_id
        SecureRandom.uuid
      end
    end
  end
end