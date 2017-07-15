require_relative '../service'

class ResolveAttempt
  class << self
    def do(auth_token, attempt_id)
      auth_token.validate!

      message = Evidence::Service.resolve_attempt(attempt_id)

      message
    end
  end
end



