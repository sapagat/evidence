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
    return unauthorized if auth_token != ENV['AUTH_TOKEN']

    key = @question.key
    return invalid_key if key.nil?

    message = Evidence::Service.instructions(key)

    answer_with(message)
  end

  post '/resolve_attempt' do
    auth_token = @question.auth_token
    return unauthorized if auth_token != ENV['AUTH_TOKEN']

    attempt_id = @question.attempt_id
    message = Evidence::Service.resolve_attempt(attempt_id)

    answer_with(message)
  end

  error Evidence::InvalidAttempt do
    reply Answer.invalid_attempt
  end

  private

  def unauthorized
    reply Answer.unauthorized
  end

  def invalid_attempt
    reply Answer.invalid_attempt
  end

  def invalid_key
    reply Answer.invalid_key
  end

  def answer_with(message)
    reply Answer.successful(message)
  end

  def reply(answer)
    status :ok
    content_type :json
    body answer.to_json
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

  class Answer
    def initialize(message)
      @answer = message
    end

    def self.successful(data)
      message = {
        'status' => 'ok',
        'data' => data
      }
      new (message)
    end

    def self.error(type)
      message = {
        'status' => 'error',
        'error' => type
      }
      new (message)
    end

    def self.unauthorized
      error('unauthorized')
    end

    def self.invalid_attempt
      error('invalid_attempt')
    end

    def self.invalid_key
      error('invalid_key')
    end

    def to_json
      JSON.dump(@answer)
    end
  end
end