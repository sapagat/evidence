require_relative '../src/controller'
require_relative '../health/server'

module Infrastructure
  Dispatcher = Rack::Builder.app do
    map '/' do
      run EvidenceController
    end

    map '/health' do
      run Health::Server.new
    end

    map '//' do
      run Proc.new { |env| ['200', {'Content-Type' => 'text/plain'}, ['Evidence Service']]}
    end
  end
end
