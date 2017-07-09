module Stubs
  class S3Client
    INSTRUCTIONS = {
      'url' => 'an_url',
      'method' => 'PUT'
    }

    class << self
      def build_instructions(filename)
        INSTRUCTIONS
      end

      def exists?(filename)
        @exists
      end

      def say_exists
        @exists = true
      end

      def say_does_not_exists
        @exists = false
      end
    end
  end
end