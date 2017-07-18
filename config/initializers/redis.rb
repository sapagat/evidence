require_relative '../../infrastructure/redis'

Infrastructure::Redis.configure do |config|
  config.host = ENV['REDIS_HOST']
  config.port =  ENV['REDIS_PORT']
  config.timeout = ENV['REDIS_TIMEOUT'].to_i
end