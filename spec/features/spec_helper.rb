ENV['RACK_ENV'] = 'test'
require_relative '../spec_helper'
require_relative 'helpers/feature_helpers'
require_relative 'helpers/attempts_helpers'
require_relative 'fixtures/s3'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed

  config.include FeatureHelpers

  config.before(:suite) do
    Infrastructure::S3.configure do |config|
      config.region = Fixtures::S3.region
      config.bucket = Fixtures::S3.bucket
      config.access_key_id = Fixtures::S3.access_key_id
      config.secret_access_key = Fixtures::S3.secret_access_key
    end
  end

  config.after(:example) do
    Attempts::TestRepository.flush
  end
end