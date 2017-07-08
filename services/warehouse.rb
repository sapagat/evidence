require_relative 's3_client'

class Warehouse
  class << self
    def instructions_for(filename)
      client.build_instructions(filename)
    end

    def exists?(filename)
      client.exists?(filename)
    end

    private

    def client
      return @client if @client

      build_client
    end

    def build_client
      @client = S3Client
    end
  end
end