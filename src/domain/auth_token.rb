class AuthToken
  class InvalidToken < StandardError; end

  def initialize(token)
    @token = token
  end

  def validate!
    raise InvalidToken if @token != shared_key
  end

  private

  def shared_key
    ENV['AUTH_TOKEN']
  end
end