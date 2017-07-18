require_relative '../../src/service/attempts'

Attempts::Repository.configure do |config|
  config.client = Attempts::RedisClient
end