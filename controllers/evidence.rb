require 'sinatra/base'
require 'json'
require_relative '../actions/provide_instructions'
require_relative '../actions/resolve_attempt'

class EvidenceController < Sinatra::Base
  disable :show_exceptions

  get '/instructions' do
    message = ProvideInstructions.do

    answer_with(message)
  end

  post '/resolve' do
    attempt_id = question['attempt_id']

    ResolveAttempt.do(attempt_id)

    answer_with({})
  end

  error ResolveAttempt::InvalidAttempt do
    halt 422
  end

  private

  def question
    JSON.parse(request.body.read)
  end

  def answer_with(message)
    status :ok
    content_type :json
    body JSON.dump(message)
  end
end