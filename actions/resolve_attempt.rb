require_relative '../services/attempts/repository'

class ResolveAttempt
  class InvalidAttempt < StandardError; end

  class << self
    def do(attempt_id)
      attempt = Attempts::Repository.find(attempt_id)

      raise InvalidAttempt if attempt.nil?

      Attempts::Repository.destroy(attempt_id)
    end
  end
end