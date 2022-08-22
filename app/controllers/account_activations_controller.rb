class AccountActivationsController < ApplicationController
    skip_before_action :authorize_request
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated?
            user.update(activated: true, activation_digest: nil)
            render json:[message:"Welcome to Countries App"]
        else
            render json:[message:"Invalid Link"]
        end
    end
        
end
