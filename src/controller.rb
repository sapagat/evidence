require 'sinatra/base'
require 'json'
require_relative 'service'
require_relative 'actions/provide_instructions'
require_relative 'actions/resolve_attempt'

class EvidenceController < Sinatra::Base
  disable :show_exceptions

  before do
    @question = Question.new(request)
  end

  post '/provide_instructions' do
    auth_token = @question.auth_token
    key = @question.key

    message = ProvideInstructions.do(auth_token, key)

    answer_with(message)
  end

  post '/resolve_attempt' do
    auth_token = @question.auth_token
    attempt_id = @question.attempt_id

    message = ResolveAttempt.do(auth_token, attempt_id)

    answer_with(message)
  end

  error Evidence::InvalidAttempt do
    reply Answer.invalid_attempt
  end

  error Unauthorized do
    reply Answer.unauthorized
  end

  error ProvideInstructions::InvalidKey do
    reply Answer.invalid_key
  end

  private

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