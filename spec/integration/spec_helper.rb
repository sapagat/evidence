require_relative '../spec_helper'
require_relative 'fixtures/s3'
require_relative '../../infrastructure/s3'

Infrastructure::S3.configure do |config|
  config.region = Fixtures::S3.region
  config.bucket = Fixtures::S3.bucket
  config.access_key_id = Fixtures::S3.access_key_id
  config.secret_access_key = Fixtures::S3.secret_access_key
end
