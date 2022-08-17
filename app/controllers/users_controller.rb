class UsersController < ApplicationController
  skip_before_action :authorize_request
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
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def confirm_email
    user = User.find_by_activation_digest(params[:id])
    if user
      user.email_activate
      render json:[message:"Welcome to Countries App"]
    else
      render json:[message:"Sorry. User does not exist"]
    end
  end

  def email_activate
    self.activated = true
    self.activation_digest = nil
    save!(:validate => false)
  end


  
  private
  
  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
    
end