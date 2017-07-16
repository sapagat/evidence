require_relative '../../../src/service/attempts'

module Attempts
  class TestRepository < Repository
    def self.flush
      @@attempts = {}
    end

    def self.store(attempt)
      @@attempts[attempt['id']] = attempt
    end

    def self.exists?(id)
      !@@attempts[id].nil?
    end
  end
end