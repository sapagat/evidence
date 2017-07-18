require 'json'
require_relative 'doctors/s3'
require_relative 'doctors/redis'

module Health
  class Server
    def call(env)
      ['200', {'Content-Type' => 'application/json'}, [response]]
    end

    private

    def response
      JSON.dump({
        'dependencies' => {
          's3' => Doctors::S3.check,
          'redis' => Doctors::Redis.check
        }
      })
    end
  end
end