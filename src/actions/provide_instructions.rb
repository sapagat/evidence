require_relative '../service'

class ProvideInstructions
  class InvalidKey < StandardError; end

  class << self
    def do(auth_token, key)
      auth_token.validate!

      attempt = create_attempt(key)
      instructions = obtain_instructions_for(key)
      {
        'attempt_id' => attempt['id'],
        'instructions' => instructions
      }
    end

    private

    def create_attempt(key)
      raise InvalidKey if key.nil?

      attempt = Attempts.create(key)
    end

    def obtain_instructions_for(key)
      Warehouse::Gateway.instructions_for(key)
    end
  end
end

