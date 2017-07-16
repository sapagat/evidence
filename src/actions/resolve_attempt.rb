require_relative '../service'

class ResolveAttempt
  class InvalidAttempt < StandardError; end
  class EvidenceNotStored < StandardError; end

  class << self
    def do(ticket)
      key = exchange(ticket)

      check_uploaded(key)

      key
    end

    private

    def exchange(ticket)
      attempt = Attempts::Service.exchange(ticket)

      raise InvalidAttempt if attempt.empty?

      attempt['key']
    end

    def check_uploaded(key)
      raise EvidenceNotStored unless Warehouse::Service.stored?(key)
    end
  end
end



