ENV['RACK_ENV'] ||= 'development'

class Boot
  INITIALIZERS_DIRECTORY = 'initializers'
  BINDINGS_DIRECTORY = 'bindings'

  class << self
    def do
      init
      bind
    end

    private

    def init
      require_files_in(INITIALIZERS_DIRECTORY)
    end

    def bind
      require_files_in(BINDINGS_DIRECTORY)
    end

    def require_files_in(directory)
      files_path = File.join(File.dirname(__FILE__), directory)
      file_paths = Dir[File.join(files_path, '*.rb')]
      file_paths.each { |file| require file }
    end
  end
end