require 'sinatra/base'
require 'json'
require_relative '../actions/provide_instructions'

class InstructionsController < Sinatra::Base
  get '/' do
    message = ProvideInstructions.do

    answer_with(message)
  end

  private

  def answer_with(message)
    status :ok
    content_type :json
    body JSON.dump(message)
  end
end
