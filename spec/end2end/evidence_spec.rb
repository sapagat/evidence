require_relative 'spec_helper'
require_relative 'helpers/http_helpers'
require 'json'

describe 'Evidence' do
  include HttpHelpers

  it 'completing an upload cycle' do
    instructions = ask_for_instructions

    resolve_upload

    expect_last_response_to_be_ok
  end

  def ask_for_instructions
    get '/instructions'
    @attempt_id = last_parsed_response['attempt_id']
  end

  def resolve_upload
    post '/resolve', { 'attempt_id' => @attempt_id }
  end

  def expect_last_response_to_be_ok
    expect(last_response.code).to eq('200')
  end
end