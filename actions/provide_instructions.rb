require_relative '../services/warehouse'
require_relative '../services/attempts'

class ProvideInstructions
  FILENAME = 'test.txt'

  class << self
    def do
      attempt = Attempts::Service.create
      instructions = Warehouse.instructions_for(FILENAME)
      {
        'attempt_id' => attempt['id'],
        'instructions' => instructions
      }
    end
  end
end