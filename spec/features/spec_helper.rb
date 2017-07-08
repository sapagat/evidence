ENV['RACK_ENV'] = 'test'
require_relative '../spec_helper'
require_relative 'helpers/feature_helpers'
require_relative 'helpers/attempts_helpers'

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
      config.region = 'test-region'
      config.bucket = 'test-bucket'
      config.access_key_id = 'test-acces-key-id'
      config.secret_access_key = 'test-secret-access-key'
    end
  end

  config.after(:example) do
    Attempts::TestRepository.flush
  end
end