require 'securerandom'

class Attempt
  attr_reader :ticket

  def self.for(payload)
    ticket = SecureRandom.uuid
    new(ticket, payload)
  end

  def initialize(ticket, payload)
    @ticket = ticket
    @payload = payload
  end

  def serialize
    @payload
  end
end

class NullAttempt
  attr_reader :ticket

  def initialize
    @ticket = nil
  end

  def serialize
    {}
  end
end