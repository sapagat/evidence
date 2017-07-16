require_relative 'service/warehouse'
require_relative 'service/attempts'
require_relative 'domain/attempt'

module Attempts
  class Service
    def self.register_attempt(key, instructions)
      payload = {
        'key' => key,
        'instructions' => instructions
      }
      attempt = Repository.register(payload)
      attempt.ticket
    end

    def self.exchange(ticket)
      attempt = Attempts::Repository.exchange(ticket)
      attempt.serialize
    end
  end
end

module Warehouse
  class Service
    def self.instructions_for(key)
      return if key.nil?

      Gateway.instructions_for(key)
    end

    def self.stored?(key)
      Gateway.exists?(key)
    end
  end
end