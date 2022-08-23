class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request, :check_token
  attr_reader :current_user
  
  private
  
  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  #Check if user's token is expired
  def check_token
    user = User.find_by!(email: params[:email])
    exp_tokens = ExpiryToken.all
    exp_tokens.each do |exp_token|
      if exp_token.exp_token == user.auth_token
        render json: [message:"Token expired"]
      end
    end
  end
  
end
