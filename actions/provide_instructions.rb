require_relative '../services/instructions'
require_relative '../services/attempts'

class ProvideInstructions
  class << self
    def do
      attempt = Attempts::Service.create
      instructions = Instructions::Service.retrieve
      {
        'attempt_id' => attempt['id'],
        'instructions' => instructions
      }
    end
  end
end