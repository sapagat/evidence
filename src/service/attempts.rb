require 'securerandom'

module Attempts
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

  class Repository
    class << self
      @@attempts = {}

      def store(attempt)
        @@attempts[attempt['id']] = attempt
      end

      def find(id)
        @@attempts[id]
      end

      def destroy(id)
       @@attempts.delete(id)
      end
    end
  end
end