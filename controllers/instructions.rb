require 'sinatra/base'
require 'json'
require_relative '../services/instructions'

class InstructionsController < Sinatra::Base
  get '/' do
    instructions = Instructions::Service.retrieve

    answer_with({'instructions' => instructions})
  end

  private

  def answer_with(message)
    status :ok
    content_type :json
    body JSON.dump(message)
  end
end
