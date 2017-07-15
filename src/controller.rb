require 'sinatra/base'
require 'json'
require_relative 'service'

class EvidenceController < Sinatra::Base
  disable :show_exceptions

  before do
    @question = Question.new(request)
  end

  post '/provide_instructions' do
    auth_token = @question.auth_token
    halt 401 if auth_token != ENV['AUTH_TOKEN']

    key = @question.key
    halt 422 if key.nil?

    message = Evidence::Service.instructions(key)

    answer_with(message)
  end

  post '/resolve_attempt' do
    auth_token = @question.auth_token
    halt 401 if auth_token != ENV['AUTH_TOKEN']

    attempt_id = @question.attempt_id
    message = Evidence::Service.resolve_attempt(attempt_id)

    answer_with(message)
  end

  error Evidence::InvalidAttempt do
    halt 422
  end

  private

  def answer_with(message)
    status :ok
    content_type :json
    body JSON.dump(message)
  end

  class Question
    def initialize(request)
      @question = JSON.parse(request.body.read)
      request.body.rewind
    end

    def auth_token
      @question['auth_token']
    end

    def attempt_id
      @question['attempt_id']
    end

    def key
      @question['key']
    end
  end
end