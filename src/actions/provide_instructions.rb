require_relative '../service'

class Unauthorized < StandardError; end

class ProvideInstructions
  class InvalidKey < StandardError; end

  class << self
    def do(auth_token, key)
      check_authorized!(auth_token)

      raise InvalidKey if key.nil?

      instructions = Evidence::Service.instructions(key)

      instructions
    end

    private

    def check_authorized!(auth_token)
      raise ::Unauthorized if auth_token != ENV['AUTH_TOKEN']
    end
  end
end

