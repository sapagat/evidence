require_relative 'service/warehouse'
require_relative 'service/attempts'

module Evidence
  class InvalidAttempt < StandardError; end

  class Service
    FILENAME = 'test.txt'

    class << self
      def instructions
        attempt = Attempts.create
        instructions = Warehouse.instructions_for(FILENAME)
        {
          'attempt_id' => attempt['id'],
          'instructions' => instructions
        }
      end

      def resolve_attempt(attempt_id)
        attempt = Attempts::Repository.find(attempt_id)

        raise InvalidAttempt if attempt.nil?
        Attempts::Repository.destroy(attempt_id)

        raise InvalidAttempt unless Warehouse.exists?(FILENAME)
      end
    end
  end
end