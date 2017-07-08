require_relative '../../../services/attempts/repository'

module Attempts
  class TestRepository < Repository
    def self.flush
      @@attempts = {}
    end

    def self.exists?(id)
      !@@attempts[id].nil?
    end
  end
end