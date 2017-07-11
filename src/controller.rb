require 'sinatra/base'
require 'json'
require_relative 'service'

class EvidenceController < Sinatra::Base
  disable :show_exceptions

  post '/provide_instructions' do
    key = question['key']
    halt 422 if key.nil?

    message = Evidence::Service.instructions(key)

    answer_with(message)
  end

  post '/resolve_attempt' do
    attempt_id = question['attempt_id']

    message = Evidence::Service.resolve_attempt(attempt_id)

    answer_with(message)
  end

  error Evidence::InvalidAttempt do
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