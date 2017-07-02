module Configurable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def configure_with(*names)
      @configuration_klass = Class.new do
        attr_accessor *names
      end
    end

    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= @configuration_klass.new
    end
  end
end