require_relative '../spec_helper'
require_relative '../../services/attempts'

describe 'Attempts service' do
  after do
    flush_attempts
  end

  describe 'create' do
    it 'provides an attempt' do
      attempt = Attempts::Service.create

      expect(attempt['id']).to be_a_uuid
    end

    it 'generates a new attempt each time' do
      first_attempt = Attempts::Service.create
      second_attempt = Attempts::Service.create

      expect(first_attempt['id']).not_to eq(second_attempt['id'])
    end

    it 'stores the attempt' do
      attempt = Attempts::Service.create

      stored_attempt = Attempts::TestRepository.find(attempt['id'])
      expect(stored_attempt).to eq(attempt)
    end
  end

  def flush_attempts
    Attempts::TestRepository.flush
  end
end

module Attempts
  class TestRepository < Repository
    def self.flush
      @@attempts = {}
    end
  end
end