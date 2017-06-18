require_relative '../controllers/instructions'

module Infrastructure
  Dispatcher = Rack::Builder.app do
    map '/instructions' do
      run InstructionsController
    end

    map '//' do
      run Proc.new { |env| ['200', {'Content-Type' => 'text/plain'}, ['Evidence Service']]}
    end
  end
end
