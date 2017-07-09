bindings_path = File.join(File.dirname(__FILE__), 'bindings')
binding_paths = Dir[File.join(bindings_path, '*.rb')]
binding_paths.each { |file| require file }