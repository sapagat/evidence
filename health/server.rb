require 'json'

module Health
  class Server
    def call(env)
      ['200', {'Content-Type' => 'application/json'}, [response]]
    end

    private

    def response
      JSON.dump({ 'status' => 'ok'})
    end
  end
end