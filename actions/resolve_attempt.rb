require_relative '../services/attempts/repository'
require_relative '../services/warehouse'

class ResolveAttempt
  class InvalidAttempt < StandardError; end

  FILENAME = 'test.txt'

  class << self
    def do(attempt_id)
      attempt = Attempts::Repository.find(attempt_id)

      raise InvalidAttempt if attempt.nil?
      Attempts::Repository.destroy(attempt_id)

      raise InvalidAttempt unless Warehouse.exists?(FILENAME)
    end
  end
end