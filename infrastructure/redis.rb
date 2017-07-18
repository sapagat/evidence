require_relative '../config/configurable'
require 'redis'

module Infrastructure
  class Redis
    include Configurable

    configure_with :url, :timeout

    def self.client
      @client ||= build_client
    end

    def self.build_client
      ::Redis.new(
        url: configuration.url,
        timeout: configuration.timeout
      )
    end
  end
end