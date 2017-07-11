require_relative 'service/warehouse'
require_relative 'service/attempts'

module Evidence
  class InvalidAttempt < StandardError; end

  class Service
    FILENAME = 'test.txt'

    class << self
      def instructions(key)
        attempt = Attempts.create(key)
        instructions = Warehouse::Gateway.instructions_for(key)
        {
          'attempt_id' => attempt['id'],
          'key' => key,
          'instructions' => instructions
        }
      end

      def resolve_attempt(attempt_id)
        attempt = Attempts::Repository.find(attempt_id)

        raise InvalidAttempt if attempt.nil?
        Attempts::Repository.destroy(attempt_id)

        raise InvalidAttempt unless Warehouse::Gateway.exists?(attempt['key'])

        {
          key: attempt['key']
        }
      end
    end
  end
end