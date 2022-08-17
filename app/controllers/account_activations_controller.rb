class AccountActivationsController < ApplicationController
    skip_before_action :authorize_request
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated?
            user.activated = true
            user.activation_digest = nil
            render json:[message:"Welcome to Countries App"]
        else
            render json:[message:"Invalid Link"]
        end
    end
        
end
