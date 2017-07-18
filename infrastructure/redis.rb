require_relative '../config/configurable'
require 'redis'

module Infrastructure
  class Redis
    include Configurable

    configure_with :host, :port, :timeout

    def self.client
      @client ||= build_client
    end

    def self.build_client
      ::Redis.new(
        host: configuration.host,
        port: configuration.port,
        timeout: configuration.timeout
      )
    end
  end
end