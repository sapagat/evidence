require_relative 'spec_helper'
require_relative 'helpers/http_helpers'

describe 'Welcome' do
  include HttpHelpers

  it '/ responds with a success code' do
    get('/')

    expect(last_response.code).to eq('200')
  end
end
