require_relative 'instructions/gateway'

module Instructions
  class Service
    class << self
      def retrieve
        instructions = Gateway.obtain_instructions
        {
          'url' => instructions['url'],
          'method' => instructions['method']
        }
      end
    end
  end
end