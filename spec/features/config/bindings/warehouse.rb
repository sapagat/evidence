require_relative '../../../../src/service/warehouse'
require_relative '../../stubs/s3_client'

Warehouse::Gateway.configure do |config|
  config.client = Stubs::S3Client
end