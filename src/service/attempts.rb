module Attempts
  class Repository
    class << self
      @@attempts = {}

      def register(payload)
        attempt = Attempt.for(payload)

        @@attempts[attempt.ticket] = payload

        attempt
      end

      def exchange(ticket)
        return NullAttempt.new unless exists?(ticket)

        payload = find(ticket)
        destroy(ticket)
        Attempt.new(ticket, payload)
      end

      private

      def destroy(id)
       @@attempts.delete(id)
      end

      def find(id)
        @@attempts[id]
      end

      def exists?(ticket)
        !@@attempts[ticket].nil?
      end

    end
  end
end
