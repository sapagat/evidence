require_relative '../../../services/attempts/repository'

module Attempts
  class TestRepository < Repository
    def self.flush
      @@attempts = {}
    end
  end
end