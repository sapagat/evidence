require_relative '../../src/service/warehouse'

Warehouse::Gateway.configure do |config|
  config.client = Warehouse::S3Client
end