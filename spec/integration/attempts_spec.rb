require_relative 'spec_helper'
require_relative '../../src/service/attempts'
require_relative 'helpers/attempts_helpers'

RSpec.describe 'Attempts service' do
  after do
    flush_attempts
  end

  describe 'create' do
    it 'provides an attempt' do
      attempt = Attempts.create(a_key)

      expect(attempt['id']).to be_a_uuid
    end

    it 'generates a new attempt each time' do
      first_attempt = Attempts.create(a_key)
      second_attempt = Attempts.create(a_key)

      expect(first_attempt['id']).not_to eq(second_attempt['id'])
    end

    it 'stores the attempt' do
      attempt = Attempts.create(a_key)

      stored_attempt = Attempts::TestRepository.find(attempt['id'])
      expect(stored_attempt).to eq(attempt)
    end

    def a_key
      'a/key.txt'
    end
  end

  def flush_attempts
    Attempts::TestRepository.flush
  end
end
