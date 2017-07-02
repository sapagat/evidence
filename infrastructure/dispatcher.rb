require_relative '../controllers/evidence'

module Infrastructure
  Dispatcher = Rack::Builder.app do
    map '/' do
      run EvidenceController
    end

    map '//' do
      run Proc.new { |env| ['200', {'Content-Type' => 'text/plain'}, ['Evidence Service']]}
    end
  end
end
