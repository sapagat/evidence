require_relative '../service'

class ProvideInstructions
  class InvalidKey < StandardError; end

  class << self
    def do(key)
      instructions = obtain_instructions_for(key)
      ticket = register_attempt(key, instructions)
      {
        'ticket' => ticket,
        'instructions' => instructions
      }
    end

    private

    def obtain_instructions_for(key)
      instructions = Warehouse::Service.instructions_for(key)

      raise InvalidKey if instructions.nil?

      instructions
    end

    def register_attempt(key, instructions)
      ticket = Attempts::Service.register_attempt(key, instructions)
      ticket
    end
  end
end
