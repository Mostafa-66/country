class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end
  
  # Service entry point - return valid user object
  def call
    {
      user: user
    }
  end
  
  private
  
  attr_reader :headers
  
  def user
    # check if user is in the database
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => e
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end
  
  # decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end
  
  # check for token in `Authorization` header
  def http_auth_header
    exp_tokens = ExpiryToken.all
    users = User.all
    if headers['Authorization'].present?
      exp_tokens.each do |exp_token|
        users.each do |user|
          if exp_token.exp_token == user.auth_token
            raise(ExceptionHandler::InvalidToken, Message.expired_token)
          end
        end
      end
      return headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end