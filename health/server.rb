require 'json'
require_relative 's3_doctor'

module Health
  class Server
    def call(env)
      ['200', {'Content-Type' => 'application/json'}, [response]]
    end

    private

    def response
      JSON.dump({
        'dependencies' => {
          's3' => S3Doctor.check
        }
      })
    end
  end
end