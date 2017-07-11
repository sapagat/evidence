require_relative '../../health/s3_doctor'
require_relative '../../config/initializers/s3'

RSpec.describe 'S3 Doctor' do
  it 'connects to s3 server' do
    result = S3Doctor.check

    expect(result).to eq({'status' => 'ok'})
  end

  context 'when there is an error checking the connection' do
    before do
      allow(Infrastructure::S3).to receive(:client)
        .and_return(ClientWithConnecitonError)
    end

    it 'says there is an error' do
      result = S3Doctor.check

      expect(result).to eq({'status' => 'error'})
    end

    class ClientWithConnecitonError
      def self.head_bucket(params)
        raise StandardError.new
      end
    end
  end
end