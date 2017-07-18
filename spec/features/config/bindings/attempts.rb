require_relative '../../../../src/service/attempts'
require_relative '../../helpers/attempts_helpers'

Attempts::Repository.configure do |config|
  config.client = Attempts::MemoryClient
end