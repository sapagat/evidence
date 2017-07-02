require_relative '../spec_helper'
require_relative '../../services/attempts'

describe 'Attempts service' do
  describe 'create' do
    it 'provides an attempt' do
      attempt = Attempts::Service.create

      expect(attempt['id']).to be_a_uuid
    end

    it 'generates a new attempt each time' do
      first_attempt = Attempts::Service.create
      second_attempt = Attempts::Service.create

      expect(first_attempt['id']).not_to eq(second_attempt['id'])
    end
  end
end