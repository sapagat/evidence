require_relative '../service'

class Unauthorized < StandardError; end

class ResolveAttempt
  class << self
    def do(auth_token, attempt_id)
      check_authorized!(auth_token)

      message = Evidence::Service.resolve_attempt(attempt_id)

      message
    end

    private

    def check_authorized!(auth_token)
      raise ::Unauthorized if auth_token != ENV['AUTH_TOKEN']
    end
  end
end



