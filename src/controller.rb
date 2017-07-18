require 'sinatra/base'
require 'json'
require_relative 'actions/provide_instructions'
require_relative 'actions/resolve_attempt'
require_relative 'domain/auth_token'

class EvidenceController < Sinatra::Base
  disable :show_exceptions

  before do
    @question = Question.new(request)
    @question.auth_token.validate!
  end

  post '/provide_instructions' do
    key = @question.key

    begin
      attempt = ProvideInstructions.do(key)

      answer_with({
        'key' => key,
        'ticket' => attempt['ticket'],
        'instructions' => attempt['instructions']
      })

    rescue ProvideInstructions::InvalidKey
      reply Answer.invalid_key
    end
  end

  post '/resolve_attempt' do
    ticket = @question.ticket

    begin
      key = ResolveAttempt.do(ticket)

      answer_with({ 'key' => key })

    rescue ResolveAttempt::EvidenceNotStored, ResolveAttempt::InvalidTicket
      reply Answer.invalid_ticket
    end
  end

  error AuthToken::InvalidToken do
    reply Answer.unauthorized
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

    def ticket
      @question['ticket']
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

    def self.invalid_ticket
      error('invalid_ticket')
    end

    def self.invalid_key
      error('invalid_key')
    end

    def to_json
      JSON.dump(@answer)
    end
  end
end