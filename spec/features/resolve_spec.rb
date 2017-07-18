require_relative 'spec_helper'
require_relative 'helpers/attempts_helpers'
require_relative '../../src/service/warehouse'

RSpec.describe 'Resolve' do
  it 'resolves when the ticket is valid' do
    Stubs::S3Client.say_exists
    store_attempt({'ticket' => '1234', 'key' => 'my_key'})

    post '/resolve_attempt', auth_message({ 'ticket' => '1234'})

    expect(last_response.status).to eq(status_ok)
    expect(last_status).to eq('ok')
    expect(last_data['key']).to eq('my_key')
  end

  context 'when the file is not stored in warehouse' do
    it 'responds with an error status' do
      Stubs::S3Client.say_does_not_exists
      store_attempt({'ticket' => '1234'})

      post '/resolve_attempt', auth_message({ 'ticket' => '1234'})

      expect(last_status).to eq('error')
      expect(last_error).to eq('invalid_ticket')
      expect(Attempts::TestRepository.exists?('1234')).to eq(false)
    end
  end

  context 'when the ticket is not valid' do
    it 'responds with an error status' do
      post '/resolve_attempt', auth_message({ 'ticket' => invalid_ticket})

      expect(last_response.status).to eq(status_ok)
      expect(last_status).to eq('error')
      expect(last_error).to eq('invalid_ticket')
    end

    def invalid_ticket
      'INVALID'
    end
  end

  context 'when not authorized' do
    it 'responds with an unauthorized error' do
      post('/resolve_attempt', message({'ticket' => 'any_id'}))

      expect(last_status).to eq('error')
      expect(last_error).to eq('unauthorized')
    end
  end

  def store_attempt(attempt)
    Attempts::TestRepository.store(attempt)
  end
end
