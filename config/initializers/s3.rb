require_relative '../../infrastructure/s3'

Infrastructure::S3.configure do |config|
  config.region = ENV['S3_REGION']
  config.access_key_id = ENV['S3_ACCESS_KEY_ID']
  config.secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
  config.bucket = ENV['S3_BUCKET']
  config.endpoint = ENV['S3_ENDPOINT']
end