require_relative 'spec_helper'
require_relative 'helpers/attempts_helpers'
require_relative '../../src/service/warehouse'


RSpec.describe 'Resolve' do
  it 'resolves when the attempt is valid' do
    allow(S3Client).to receive(:exists?).and_return(true)
    store_attempt({'id' => '1234'})

    post '/resolve', message({ 'attempt_id' => '1234'})

    expect(last_response.status).to eq(status_ok)
  end

  context 'when the file is not stored in warehouse' do
    it 'responds with an error status' do
      allow(S3Client).to receive(:exists?).and_return(false)
      store_attempt({'id' => '1234'})

      post '/resolve', message({ 'attempt_id' => '1234'})

      expect(last_response.status).to eq(error_status)
      expect(Attempts::TestRepository.exists?('1234')).to eq(false)
    end
  end

  context 'when the attempt is not valid' do
    it 'responds with an error status' do
      post '/resolve', message({ 'attempt_id' => invalid_attempt_id})

      expect(last_response.status).to eq(error_status)
    end

    def invalid_attempt_id
      'INVALID'
    end
  end

  def store_attempt(attempt)
    Attempts::TestRepository.store(attempt)
  end
end