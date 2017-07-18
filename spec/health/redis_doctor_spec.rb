require_relative '../../health/doctors/redis'
require_relative '../../config/initializers/redis'

RSpec.describe 'Redis Doctor' do
  it 'connects to redis server' do
    result = Doctors::Redis.check

    expect(result).to eq({'status' => 'ok'})
  end

  context 'when server is not reacheable' do
    before do
      allow(Infrastructure::Redis).to receive(:build_client).
        and_return(ClientWithConnecitonError)
    end

    it 'says that there is an error' do
      result = Doctors::Redis.check

      expect(result).to eq({'status' => 'error'})
    end

    class ClientWithConnecitonError
      def self.ping
        raise StandardError.new
      end
    end
  end
end