require_relative '../../infrastructure/redis'

Infrastructure::Redis.configure do |config|
  config.url = ENV['REDIS_URL']
  config.timeout = ENV['REDIS_TIMEOUT'].to_i
end