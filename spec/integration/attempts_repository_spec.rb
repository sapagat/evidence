require_relative 'spec_helper'
require_relative '../../src/service/attempts'
require_relative '../../config/initializers/redis'

RSpec.describe 'Attempts Repository' do
  before do
    Attempts::Repository.configure do |config|
      config.client = Attempts::RedisClient
    end
  end

  after do
    Attempts::TestClient.flush
  end

  it 'provides an attempt after registering its payload' do
    attempt = Attempts::Repository.register({'key' => 'value'})

    stored = Attempts::TestClient.find(attempt.ticket)
    expect(stored).to eq({'key' => 'value'})
  end

  it 'provides an attempt in exchange of its ticket' do
    Attempts::TestClient.store('ticket', {'key' => 'value'})

    stored_attempt = Attempts::Repository.exchange('ticket')

    expect(stored_attempt.serialize).to eq({'key' => 'value'})
  end
end

module Attempts
  class TestClient < RedisClient
    def self.flush
      redis_client.flushdb
    end
  end
end