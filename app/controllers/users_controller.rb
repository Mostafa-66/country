class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  attr_accessor :activation_token
    
  # POST /signup
  # return authenticated token upon signup
  def create
    @user = User.create!(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      auth_token = AuthenticateUser.new(@user.email, @user.password).call
      response = { message: "Please check your email to activate your account.", 
        auth_token: auth_token }
      json_response(response, :created)
      @user.update(auth_token: auth_token)
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  #PUT /complete
  #Users complete thiere profile
  def complete
    @user = User.find_by!(email: params[:email])
    if @user && @user.activated?
      if @user.update(user_params2)
        @user.update(completed: true)
        render json: [message: "Profile completed"]
      end
    else
      render json: [message: "Please activate your account"]
    end
  end

  
  private
  
  def user_params
    params.permit(
      :email,
      :password,
      :password_confirmation
    )
  end

  def user_params2
    params.permit(
      :name,
      :phone,
      :gender
    )
  end
    
end