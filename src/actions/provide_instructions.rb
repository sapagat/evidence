require_relative '../service'

class ProvideInstructions
  class InvalidKey < StandardError; end

  class << self
    def do(auth_token, key)
      auth_token.validate!

      raise InvalidKey if key.nil?

      instructions = Evidence::Service.instructions(key)

      instructions
    end
  end
end

