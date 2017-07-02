module Attempts
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