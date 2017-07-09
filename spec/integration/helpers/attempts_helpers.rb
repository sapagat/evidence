require_relative '../../../src/service/attempts'

module Attempts
  class TestRepository < Repository
    def self.flush
      @@attempts = {}
    end
  end
end