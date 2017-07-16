require_relative '../service'

class ResolveAttempt
  class << self
    def do(auth_token, attempt_id)
      auth_token.validate!

      key = exchange_attempt(attempt_id)

      check_uploaded!(key)

      key
    end

    private

    def exchange_attempt(attempt_id)
      attempt = Attempts::Repository.find(attempt_id)

      raise Evidence::InvalidAttempt if attempt.nil?
      Attempts::Repository.destroy(attempt_id)

      attempt['key']
    end

    def check_uploaded!(key)
      raise Evidence::InvalidAttempt unless Warehouse::Gateway.exists?(key)
    end
  end
end



