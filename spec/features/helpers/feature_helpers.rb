require 'rack/test'
require_relative '../../../infrastructure/dispatcher'
require 'json'

module FeatureHelpers
  def self.included(base)
    base.send(:include, Rack::Test::Methods)
  end

  def app
    Infrastructure::Dispatcher
  end

  def status_ok
    200
  end

  def last_status
    last_parsed_response['status']
  end

  def last_data
    last_parsed_response['data']
  end

  def last_error
    last_parsed_response['error']
  end

  def auth_message(payload)
    payload['auth_token'] = ENV['AUTH_TOKEN']
    message(payload)
  end

  def message(payload)
    JSON.dump(payload)
  end

  def last_parsed_response
    JSON.parse(last_response.body)
  end
end