require 'sinatra/base'
require 'json'
require_relative 'actions/provide_instructions'
require_relative 'actions/resolve_attempt'
require_relative 'domain/auth_token'

class EvidenceController < Sinatra::Base
  disable :show_exceptions

  before do
    @question = Question.new(request)
  end

  post '/provide_instructions' do
    auth_token = @question.auth_token
    key = @question.key

    result = ProvideInstructions.do(auth_token, key)

    answer_with({
      'key' => key,
      'attempt_id' => result['attempt_id'],
      'instructions' => result['instructions']
    })
  end

  post '/resolve_attempt' do
    auth_token = @question.auth_token
    attempt_id = @question.attempt_id

    key = ResolveAttempt.do(auth_token, attempt_id)

    answer_with({ 'key' => key })
  end

  error Evidence::InvalidAttempt do
    reply Answer.invalid_attempt
  end

  error AuthToken::InvalidToken do
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
      AuthToken.new(@question['auth_token'])
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