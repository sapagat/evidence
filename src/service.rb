require_relative 'service/warehouse'
require_relative 'service/attempts'

module Evidence
  class InvalidAttempt < StandardError; end
end